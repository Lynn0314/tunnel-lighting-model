%% 计算简化亮度系数的两个角度：光线入射以及观察面和入射面的夹角beta
function [tanGamma,beta] = calQAngle(CoorC, CoorD)
CoorQ = [0,-60,0]; %% 观察点的坐标值（在平面上的投影，实际计算是1.5m高）
CoorB = [CoorD(1),CoorD(2),0];
tanGamma = sqrt((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2)))/CoorD(3);
cosBeta = ((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2))^2+(CoorC(1)-CoorQ(1))^2+(CoorC(2)-CoorQ(2))^2-(CoorQ(1)-CoorB(1))^2-(CoorQ(2)-CoorB(2))^2)/2/sqrt((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2))^2)/sqrt((CoorC(1)-CoorQ(1))^2+(CoorC(2)-CoorQ(2))^2);
beta = rad2deg(acos(cosBeta));