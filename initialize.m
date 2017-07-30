function [params,mop,pop,state]= initialize(params,mop,pop,state)
    num_nod               = params.popsize;
    inds                  = randompoint(mop, num_nod);
    

    
    %% 评价每一个个体
    [inds,state]          = evaluate(inds,mop,state);
    v                     = [inds.objective];
    %% 初始化理想点和参考点
    params.idealmin       = min(v,[],2);
    params.reference      = max(v,[],2);

    %% 种群初始化
    noval                 = v-repmat(params.idealmin,[1,num_nod]);
    team                  = group(params,pop,noval);
    for i=1:params.num_class
        num_p             = length(team{i});
        
        if num_p<=pop(i).num_ind
            tst                      = floor(num_nod*rand(1,pop(i).num_ind-num_p))+1; %随机选出几个，比如之前分配到这个群里只有一个，那么就再选出9个来，10个为一个组
            selind                   = inds([team{i},tst]);
            pop(i).inter             = selind;
        else
            selind                   = inds(team{i});
            pop(i).inter             = selection(params,selind,pop(i)); %nsgaii
        end
        aa = num2cell( repmat(i,pop(i).num_ind,1) );
        [pop(i).inter.class] = aa{:};
        pop(i).best = zeros(params.num_class,1);

    end 
    %% 初始化精英集
    if ( strcmpi(params.useArchive, 'yes'))
        nspop           = ndsort(params,[pop.inter]);
        state.archive   = nspop([nspop.rank]==1); 
    end 
end


%% 产生个体
function ind = randompoint(prob, n)
    if (nargin==1)
        n=1;
    end

    numb = prob.monit_numb;
    point = ones(prob.pd, n);
    for i = 1:n
        point(:,i) =  point(:,i).*prob.domain(:,1);
        loc = randperm(prob.pd, numb);        
        point(loc,i) = 1;
        point(loc,i) = point(loc,i).*prob.domain(loc,2);
    end
    cellpoints = num2cell(point, 1);
    indiv = get_structure('individual');
    ind = repmat(indiv, [1, n]);
    [ind.parameter] = cellpoints{:};
    
end

