function pop = ndsort( pop)
   
    N = length(pop);    %popsize

    for i = 1:N
        pop(i).rank = 0;
        pop(i).distance = 0;
    end
       
    [pop,front] = calcRank(pop);      % ���������Ⱥ�ÿһ��ĸ���ָ��

    %*************************************************************************
    % 3. Calculate the distance
    %*************************************************************************

    pop = calcCrowdingDistance( pop, front);
end





