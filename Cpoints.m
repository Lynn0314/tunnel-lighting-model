clc;
clear;
k=1;
Yc = zeros(3,600);

%%  计算点的坐标信息，第一行Y坐标，第二行X坐标，第三行为Z坐标
for  j=0.5:1:100
    for i = -3.75:1.5:3.75
        Yc(1,k)=j;
        Yc(2,k)=i;
        k = k+1;
    end
end
Yc