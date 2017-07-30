function p=water(p)
 p.name='water';
 p.od = 2;
 p.pd = 126;
 p.monit_numb = 5;
 range = ones(p.pd,2); 
 range(:,1)      =  0;
 p.domain=  range;
 p.func = @evaluate;
    %F2  evaluation function.
    function [y] = evaluate(x)
       global demand water_time detec_like water_people;
%        x = xlsread('testz3.xlsx');
%        x = x';
       [dim, num]  = size(x);
       [~, timenum] = size(demand);
       nodenum = dim;
       matrix_time = zeros(dim, timenum);
       matrix_detec = zeros(dim, timenum);
       matrix_people = zeros(dim, timenum);
       matrix_demand = zeros(dim, timenum);
       
       for i = 1:dim
          for j = 1:timenum
              tmp_detec = detec_like(i,j);
              tmp_detec = tmp_detec{1,1};
              
              tmp_time = water_time(i,j);
              tmp_time = tmp_time{1,1};
              
              tmp_demand = demand(i,j);
              tmp_demand = tmp_demand{1,1};
              
              tmp_people = water_people(i,j);
              tmp_people = tmp_people{1,1};
              
              td = min(tmp_time(x==1));
              if td~= 11520
                matrix_time(i,j) = td;
              end
              
              detec = tmp_detec(x==1);
              if sum(detec) >= 1
                  matrix_detec(i,j) = 1;
              end
              
              if ~isempty(tmp_people)
                  if td ~= 11520
                      loc = find(tmp_time == td);
                       matrix_people(i,j) = tmp_people(loc(1));
                      matrix_demand(i,j) = tmp_demand(loc(1));
                  end
              end
              
          end
       end
       tmp1 = sum(sum(matrix_time));
       if tmp1 == 0
           z1 = inf;
       else
           z1 = sum(sum(matrix_time))/(nodenum*timenum);
       end
       
       tmp4 = sum(sum(matrix_detec));
       if tmp4 == 0
           z4 = inf;
       else
           z4 = - sum(sum(matrix_detec))/(nodenum*timenum) + 100000* (abs(sum(x)-p.monit_numb));
       end
       
       
       tmp2 = sum(sum(matrix_people));
       if tmp2 == 0
           z2 = inf;
       else
           z2 = tmp2/(nodenum*timenum);
       end
         
              
       tmp3 = sum(sum(matrix_demand));
       if tmp3 == 0
           z3 = inf;
       else
           z3 = tmp3/(nodenum*timenum);
       end
    
       y(1,:)      = z4;
       y(2,:)      = z1;
       
%        y2(1,:)      = z4;
%        y2(2,:)      = z2;
%        
%        y3(1,:)      = z4;
%        y3(2,:)      = z3;
    
    end
end