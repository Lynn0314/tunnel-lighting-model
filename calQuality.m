function [Lavg, U0, U11, U12, U13] = calQuality(L)
%% 根据输入的9*100个计算点的亮度数据计算亮度平均值，路面总均匀度，中线纵向均匀度
Lavg = mean(L);
U0 = min(L)/Lavg;
Lmid1 = zeros(100);
Lmid2 = zeros(100);
Lmid3 = zeros(100);
for i = 1:100
    Lmid1(i) = L(2+(i-1)*9);
    Lmid2(i) = L(5+(i-1)*9);
    Lmid3(i) = L(8+(i-1)*9);
end
U11 = min(Lmid1)/max(Lmid1);
U12 = min(Lmid2)/max(Lmid2);
U13 = min(Lmid3)/max(Lmid3);
