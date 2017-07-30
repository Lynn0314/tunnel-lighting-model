function [params,mop,pop,state]=evolution(params,mop,pop,state,CMpara)
global pos
    % 更新杂交变异参数
    CMpara{1}.delta       = (1- state.reg_obj/params.iteration)^0.7;  

    % 1)杂交变异产生新子代

    [newpop,state,pop]        = CMOp(params,mop,pop,state,CMpara,pos);
    
    % 2)通过选择算子得到新的种群
    [pop,params,state]    = extractPop(pop,newpop,params,state);   
end

%% 计算概率
function pos = CalcuP(pop,params,state,pos)
global  hash 
       
       total = hash ;
       p = (total)./sum(total);
       pos = p;
       for i = 2:length(p)
           pos(i) = pos(i-1) + pos(i);
       end      
end







%% 产生子代
function [newpop,state,pop] = CMOp(params,mop,pop,state,CMpara,pos)

   PM                              = [pop.inter];
    newpop                          = pop;
    for i=1:params.num_class
        newinter                    = pop(i).inter;
        if pop(i).CMtype == 1
            para                    = CMpara{pop.CMtype};
            for j=1:pop(i).num_ind
                parent1                 = pop(i).inter(j);
                if rand> para.selectPro
                    parent2             = PM(floor(rand*params.popsize)+1);
                else
                    loc                 = floor(rand*pop(i).num_ind)+1;
                    parent2             = pop(i).inter(loc);
                end
                newinter(j)             = creChildCEN(parent1,parent2,para,mop);
            end
            [newinter,state]            = evaluate(newinter,mop,state);
            newpop(i).inter             = newinter;
        elseif pop.CMtype == 2
            
            
        else
            
            
        end
    end
end




%% 基于中心的杂交变异算子
function childind = creChildCEN(parent1,parent2,para,mop)
    % 杂交算子
    childind = get_structure( 'individual' );
    x1       = parent1.parameter;
    x2       = parent2.parameter;
    range_x  = mop.domain;
    rnd      = 2*(1-rand^(-para.delta))*(rand-0.5);
    x_cld    = x1+rnd*(x2-x1);
    for i = 1:mop.pd   
        if x_cld(i) < range_x(i,1)
            x_cld(i) = range_x(i,1)+0.5*rand*(x1(i)-range_x(i,1));
        elseif x_cld(i) > range_x(i,2)
            x_cld(i) = range_x(i,2)-0.5*rand*(range_x(i,2)-x1(i));
        end
    end   
    % 变异算子
    lst = find(rand(1,mop.pd) <= para.pmuta);
    len = length(lst);
    if len == 0
        len = 1;
        lst = floor(rand*mop.pd)+1;
    end
    for j = 1:len
        yl  = range_x(lst(j),1);
        yu  = range_x(lst(j),2);
        y   = x_cld(lst(j));
        rnd = 0.5*(rand-0.5)*(1-rand^(-para.delta));
        y   = y+rnd*(yu-yl);
        if y > yu
            y = yu-0.5*rand*(yu-x_cld(lst(j)));
        elseif y < yl
            y = yl+0.5*rand*(x_cld(lst(j))-yl);
        end
        x_cld(lst(j)) = y;
    end
    childind.parameter = x_cld;
end


function childind = creChildDE(para,mop,parent1,parent2,parent3,parent4,parent5)
    childind = get_structure( 'individual' );
    DE_F = 0.5;
    p1 = parent1.parameter;
    p2 = parent2.parameter;
    p3 = parent3.parameter;
    p4 = parent4.parameter;
    p5 = parent5.parameter;
    % build help_child
    newpoint = p1 + DE_F.*(p2-p3) + DE_F.*(p4-p5);
     %repair the new value
    rnds            = rand(mop.pd,1);
    xupp = mop.domain(:,2);
    xlow = mop.domain(:,1);
    pos             = newpoint>xupp;
    if sum(pos)>0
        newpoint(pos) = p1(pos,1) + rnds(pos,1).*(xupp(pos)-p1(pos,1));
    end
    pos             = newpoint<xlow;
    if sum(pos)>0
        newpoint(pos) = p1(pos,1) - rnds(pos,1).*(p1(pos,1)-xlow(pos));
    end
    
    childind.parameter             = realmutate(newpoint, para.pmuta, mop);

   
end

function ind = realmutate(ind, rate, mop)
%REALMUTATE Summary of this function goes here
%   Detailed explanation goes here
% global params;
 xupp = mop.domain(:,2);
    xlow = mop.domain(:,1);
    eta_m = 20;

    for j = 1:mop.pd
      r = rand();
      if (r <= rate) 
        y       = ind(j);
        yl      = xlow(j);
        yu      = xupp(j);
        delta1  = (y - yl) / (yu - yl);
        delta2  = (yu - y) / (yu - yl);

        rnd     = rand();
        mut_pow = 1.0 / (eta_m + 1.0);
        if (rnd <= 0.5) 
          xy    = 1.0 - delta1;
          val   = 2.0 * rnd + (1.0 - 2.0 * rnd) * (xy^(eta_m + 1.0));
          deltaq= (val^mut_pow) - 1.0;
        else 
          xy    = 1.0 - delta2;
          val   = 2.0 * (1.0 - rnd) + 2.0 * (rnd - 0.5) * (xy^ (eta_m + 1.0));
          deltaq= 1.0 - (val^mut_pow);
        end

        y   = y + deltaq * (yu - yl);
        if y < yl, y = yl; end
        if y > yu, y = yu; end

        ind(j) = y;        
      end
    end
end




%% 更新种群
function [pop,params,state] = extractPop(pop,newpop,params,state)
 global hash hashrank lp gl 
    % 更新方式   
     allind              = [pop.inter,newpop.inter];
     val                 = [allind.objective];
     num_nod             = size(val,2);
     params.idealmin     = min([params.idealmin,val],[],2);
     params.reference    = max(val,[],2)+1;
     noval               = val-repmat(params.idealmin,[1,num_nod]);
     team                = group(params, pop, noval);



     for i=1:params.num_class
        num_p            = length(team{i});
        if num_p<=pop(i).num_ind
            tst                      = floor(num_nod*rand(1,pop(i).num_ind-num_p))+1;
            selind                   = allind([team{i},tst]);
            pop(i).inter             = selind;
        else
            selind                   = allind(team{i});
            pop(i).inter             = selection(params,selind,pop(i));
        end
        aa = num2cell( repmat(i,pop(i).num_ind,1) );
        [pop(i).inter.class] = aa{:};
     end
          
     
        
end
%      if mod( state.currentGen,lp ) == 0
%          for i = 1:params.num_class
%             pop(i).best = zeros(params.num_class,1);
%          end
%      end
         
    
     


