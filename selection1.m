function [individual]=selection1(params,individual,oldpop)
     if(nargin < 3)
         num          = params.popsize;   
     else
         num          = params.popsize;
     end
     [individual,ind1]   = selectNS(individual,num); 
%      if oldpop.Stype==1
%          [individual,ind1]   = selectNS(individual,num);     
%      elseif oldpop.Stype==2
%          individual   = selectMM(individual,params,num);
%      elseif oldpop.Stype==3
%          individual   = selectHY(individual,params,num); 
%      else
%          error( 'No defined the select method');
%      end
end

function nextpop   = selectHY(individual,params,num)
    [individual,front]  = calcRank(individual);
    nextpop      = individual(1:num);    %just for initializing
    n            = 0;             % individuals number of next population
    rank         = 1;             % current rank number
    idx          = front(rank).f;
    numInd       = length(idx);   % number of individuals in current front
    while( n + numInd <= num )
        nextpop( n+1 : n+numInd ) = individual( idx );
        n         = n + numInd;
        rank      = rank + 1;
        idx       = front(rank).f;
        numInd    = length(idx);
    end
    if n<num
        while (n + length(idx)>num)
            loc = removebyhy(individual(idx),params);     
            idx(loc)  = [];
        end
        nextpop( n+1 : num) = individual( idx );
    end
end


function elementInd = removebyhy(individual,params)
    frontObjectives = [individual.objective]';
    [frontsize,nObj]= size(frontObjectives);
    
    refPoint        = params.reference;
    if nObj == 2
        [frontObjectives IX] = sortrows(frontObjectives, 1);
        deltaHV(IX(1)) = ...
            (frontObjectives(2,1) - frontObjectives(1,1)) .* ...
            (refPoint(2) - frontObjectives(1,2));
        for i = 2:frontsize-1
            deltaHV(IX(i)) = ...
                (frontObjectives(i+1,1) - frontObjectives(i,1))...
                .* ...
                (frontObjectives(i-1,2) - frontObjectives(i,2));
        end;
        deltaHV(IX(frontsize)) = ...
            (refPoint(1) - frontObjectives(frontsize,1)) .* ...
            (frontObjectives(frontsize-1,2) - frontObjectives(frontsize,2));
    else
        currentHV = Hypervolume_MEX(frontObjectives, refPoint);
        deltaHV = zeros(1,frontsize);
        for i=1:frontsize
            myObjectives = frontObjectives;
            myObjectives(i,:)=[];
            myHV = Hypervolume_MEX(myObjectives, refPoint);
            deltaHV(i) = currentHV - myHV;
        end
    end
    [deltaHV,elementInd]=min(deltaHV);
end









function [nextpop,pop] = selectNS(pop,num)

    N = length(pop);    %popsize
    for i = 1:N
        pop(i).rank = 0;
        pop(i).distance = 0;
    end
    
    % 2) 计算层次
    [pop,front] = calcRank(pop);      % 计算个体的秩和每一层的个体指标

    %*************************************************************************
    % 3. Calculate the distance
    %*************************************************************************
    pop          = calcCrowdingDistance( pop, front);
    
    % 4.更新
    nextpop      = pop(1:num);    %just for initializing
    n            = 0;             % individuals number of next population
    rank         = 1;             % current rank number
    idx          = front(rank).f;
    numInd       = length(idx);   % number of individuals in current front
  
    while( n + numInd <= num )
        nextpop( n+1 : n+numInd ) = pop( idx );
        n = n + numInd;
        rank = rank + 1;
        idx = front(rank).f;
        numInd = length(idx);
    end
    if( n < num )
        distance   = [pop(idx).distance];
        distance   = [distance', idx'];
        distance   = sortrows( distance, -1);      
        idxSelect  = distance( 1:num-n, 2);          
        nextpop(n+1 : num) = pop(idxSelect);
    end
end

%% 计算拥挤距离
function pop = calcCrowdingDistance(pop, front)
    numObj = length( pop(1).objective );  % number of objectives
    for fid = 1:length(front)
        idx = front(fid).f;
        frontPop = pop(idx);        % frontPop : individuals in front fid

        numInd = length(idx);       % nInd : number of individuals in current front

        obj = [frontPop.objective]';
        obj = [obj, idx'];          % objctive values are sorted with individual ID
        for m = 1:numObj
            obj = sortrows(obj, m);

            colIdx = numObj+1;
            pop( obj(1, colIdx) ).distance = Inf;         % the first one
            pop( obj(numInd, colIdx) ).distance = Inf;    % the last one

            minobj = obj(1, m);         % the maximum of objective m
            maxobj = obj(numInd, m);    % the minimum of objective m

            for i = 2:(numInd-1)
                id = obj(i, colIdx);
                pop(id).distance = pop(id).distance + (obj(i+1, m) - obj(i-1, m)) / (maxobj - minobj);
            end
        end
    end
end



function nextpop = selectMM(pop,params,num)   
     val                 = [pop.objective];
     num_nod             = size(val,2);
     nextpop             = pop(1:num);
     noval               = val-repmat(params.idealmin,[1,num_nod]);
     weight              = defineweight(noval,num);
    for j=1:num
        max_evo          = max(repmat(weight(:,j),[1,num_nod]).*noval);
        [cfval,cfloc]    = min(max_evo);
        nextpop(j)       = pop(cfloc);
        pop(cfloc)       = [];
        noval(:,cfloc)   = [];
        num_nod          = num_nod-1;
    end
end

%% 定义权重
function weight = defineweight(noval,num)
% noval：标准化的目标值
% num: 权重的数目
%      1) 把目标值投影到单位球面上
     [dim,no]    = size(noval);
     unit        = noval./(repmat(sqrt(sum(noval.^2)),[dim,1]));
     % 2) 计算任意两个投影之间的距离 
     distmatrix  = dist(unit);
     % 3) 逐个添加相距最远的点
     Jde         = 1:no;
     loc         = floor(rand*no)+1;
     Jde(loc)    = [];
     while length(loc)<num
         [inval,index]   = max(min(distmatrix(loc,Jde),[],1));
         loc             = [loc;Jde(index)];
         Jde(index)      = []; 
     end
     weight     = 1./unit(:,loc);
end







