function [params,mop,pop,CMpara]=inputparams(name_f,params)
    
    % 1）初始化真是的有效界面
%     if( strcmpi(params.isCauIGD, 'yes'))
%         PFStar   = load(strcat('PFStar/pf_',name_f,'.dat'));
%         params.PFStar   =  PFStar';
%     end
    
    % 2)初始化种群规模，最大进化代数，子种群的数目
    mop           = testmop(name_f);
    [params,mop]  = inputparameter(params,mop);
    
    
    % 3)初始化中心点和子种群的中心规模
    val_cp                 = Weight(params.num_class,mop.od);
    center                 = val_cp./repmat(sqrt(sum(val_cp.^2)),[mop.od,1]);
    params.num_class       = size(center,2);
    sub                    = get_structure('subclass');
    pop                    = repmat(sub, [1,params.num_class]);
    for i=1:params.num_class
        pop(i).center         = center(:,i);
    end

    % 4) 初始化每一个子种群的种群规模
    temv1     = mod(params.popsize,params.num_class);
    temv2     = floor(params.popsize/params.num_class);
    for i=1:temv1
        pop(i).num_ind=temv2+1;
    end
    for i=temv1+1:params.num_class
        pop(i).num_ind=temv2;
    end
    
    % 5）初始化每一个子种群的杂交变异方式
    for i=1:params.num_class
        pop(i).CMtype  = floor(rand*1)+1;       
    end
    
    % 6) 初始化每一个子种群的选择方式
    for i=1:params.num_class
%         switch name_f
%             case {'MOP6', 'MOP7', 'F6', 'UF8', 'UF9', 'UF10'}
%                 pop(i).Stype   = 1; %floor(rand*3)+1;
%             otherwise
%                 pop(i).Stype = 3;
%         end
        pop(i).Stype = 3;
    end
    
    % 7）初始化杂交变异参数
    CMpara{1}          = get_structure('CENparas');
    CMpara{2}          = get_structure('DEparas');
    CMpara{3}          = get_structure('SBXparas');
    CMpara{1}.pmuta    = 1/mop.pd;
    
    params.idealmin    = 1000000000000*ones(mop.od,1);    
end



function [params,mop]=inputparameter(params,mop)
           params.iteration   = 150000; 
            params.num_class   = 10;
            params.popsize     = 500;
%    switch upper(mop.name)
%     case {'MOP1','MOP2','MOP3','MOP4','MOP5'}
%            params.iteration   = 300000; %
%            params.num_class   = 10;
%            params.popsize     = 100;

%    end 
end

function val_w = Weight(popsize,objDim)   
    if objDim==2
        start      = 1/(popsize*100000);
        val_w(1,:) = linspace(start,1-start,popsize);
        val_w(2,:) = ones(1,popsize)-val_w(1,:);
    elseif objDim==3
        val_w     = assign3(popsize,1);
    elseif objDim==4
        val_w          = zeros(objDim,popsize); 
        [numplane,numpoint]=comline2(popsize);
        start      = 1/(numplane*10);
        val_one    = linspace(start,1-start,numplane);
        reg        = 1;
        for i=1:numplane
            nump   = numpoint(numplane-i+1);
            if nump>1
                val    = zeros(4,nump);
                sideL  = 1-val_one(i);
                val(1:3,:)=assign3(nump,sideL);
                val(4,:)=val_one(i);
            else
                val    = zeros(4,nump);
                val(1)=(1-val_one(i))/2;
                val(2)=(1-val_one(i))/2;
                val(3)=(1-val_one(i))/2;
                val(4)=val_one(i);
            end
            val_w(:,reg:reg+nump-1)=val;
            reg=reg+nump;
        end
    end
end


function val_w = assign3(popsize,sideL) 
     val_w          = zeros(3,popsize);   
     [numline,numpoint]=comline2(popsize);
     start      = sideL/(numline*5);
     val_one    = linspace(start,sideL-start,numline);
     reg        = 1;
     for i=1:numline
         nump   = numpoint(numline-i+1);
         if nump>1
             val    = zeros(3,nump);
             Lline  = sideL-val_one(i);
             lstart = Lline/(10*nump);
             val(1,:)=linspace(lstart,Lline-lstart,nump);
             val(2,:)=Lline-val(1,:);
             val(3,:)=val_one(i);
         else
             val    = zeros(3,nump);
             val(1)=(sideL-val_one(i))/2;
             val(2)=(sideL-val_one(i))/2;
             val(3)=val_one(i);
         end
         val_w(:,reg:reg+nump-1)=val;
         reg=reg+nump;
     end
end

function [numline,numpoint]=comline2(popsize)
    numline    = round((sqrt(popsize*8+1)-1)/2);
    numpoint   = 1:numline;
    vp         = (numline+1)*numline/2;
    disnum     = popsize-vp;
    numpoint(numline-abs(disnum)+1:numline)=numpoint(numline-abs(disnum)+1:numline)+sign(disnum)*ones(1,abs(disnum));  
end

