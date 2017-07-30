function pop = ndsort( pop)
   
    N = length(pop);    %popsize

    for i = 1:N
        pop(i).rank = 0;
        pop(i).distance = 0;
    end
       
    [pop,front] = calcRank(pop);      % 计算个体的秩和每一层的个体指标

    %*************************************************************************
    % 3. Calculate the distance
    %*************************************************************************

    pop = calcCrowdingDistance( pop, front);
end





