function p=lightdesign(p)
p.name='water';
p.od = 4;
p.pd = 5;
p.monit_numb = 3;
%      设置变量取值范围
range = ones(p.pd,2);
range(1,1) = -20;%纵横向的角度都设置为最大20度
range(2,1) = -20;
range(3,1) = 0.1; %小功率LED灯，要满足频率要求，需要>15HZ,l<1.48m
range(4,1) = 4;%隧道设计高度为4.5m,最小设置为4
range(5,1) = 0;%车道宽度为9m，在中间建立坐标系，即灯具横向最远为4.5m

range(1,2) = 20;%纵横向的角度都设置为最大20度
range(2,2) = 20;
range(3,2) = 2; %小功率LED灯，要满足频率要求，需要>15HZ,l<1.48m
range(4,2) = 4.5;%隧道设计高度为4.5m
range(5,2) = 4.5;%车道宽度为9m，在中间建立坐标系，即灯具横向最远为4.5m

p.domain=  range;
p.func = @evaluate;
%F2  evaluation function.
    function [y] = evaluate(x)
        %        x = xlsread('testz3.xlsx');
        %        x = x';
        global cpoints;
        %        [dim, num]  = size(x);
        %  alpha, beta,l,h,w,CPoints
        L = calLMatrix(x(1),x(2),x(3),x(4),x(5),cpoints);
        
        Lavg = mean(mean(L));
        Lmin_global = min(min(L));
        Lrmin_1 = min(L(:,101:200));
        Lrmax_1 = max(L(:,101:200));
        Lrmin_2 = min(L(:,401:500));
        Lrmax_2 = max(L(:,401:500));
        Lrmin_3 = min(L(:,701:800));
        Lrmax_3 = max(L(:,701:800));
        
        %% objective 1: caculate Lavg Lavg_best = 4.5
        Lavg_best = 4.5;
        if Lavg<=0.8*Lavg_best
            y1=0.01*Lavg/(0.8*Lavg_best);
        elseif Lavg>0.8*Lavg_best&&Lavg<=Lavg_best
            y1=0.01+0.99*(Lavg-0.8*Lavg_best)/(0.2*Lavg_best);
        else
            y1=1+0.005*(Lavg-Lavg_best)/(0.5*Lavg_best);
        end
        
        
        %% objective 2: 亮度均匀度 U0_best = 0.4
        U0_best = 0.4;
        U0 = Lmin_global/Lavg;
        if U0<=0.8*U0_best
            y2=0.01;
        elseif U0>0.8*U0_best&&U1<=U0_best
            y2=0.01+0.99*(U0-0.8*U0_best)/(0.2*U0_best);
        else
            y2=1+0.3*(U0-U0_best);
        end
        
        %% objective 3: 中线亮度均匀度 U1_best = 0.6
        U1_best = 0.6;
        U13 = [ Lrmin_1/Lrmax_1,Lrmin_2/Lrmax_2,Lrmin_3/Lrmax_3];
        y3 = 1;
        for i = 1:3
            if U13(i)<=0.8*U1_best
                z=0.01;
            elseif U13(i)>0.8*U1_best&&U13(i)<=U1_best
                z=0.01+0.99*(U13(i)-0.8*U1_best)/(0.2*U1_best);
            else
                z=1+0.3*(U13(i)-U1_best);
            end
            y3=y3*z;
        end
        
        %% objective 4：布灯数目
        y4 = 100/x(3);
        
        y(1,:) = y1;
        y(2,:) = y2;
        y(3,:) = y3;
        y(4,:) = y4;    
    end

end