clc;
clear;
k=1;
Yc = zeros(3,600);

%%  ������������Ϣ����һ��Y���꣬�ڶ���X���꣬������ΪZ����
for  j=0.5:1:100
    for i = -3.75:1.5:3.75
        Yc(1,k)=j;
        Yc(2,k)=i;
        k = k+1;
    end
end
Yc