function theta = calTheta(CoorC,CoorD,alpha, beta1)
cosTheta = CoorD(3)+ tand(alpha)*(CoorC(1)-CoorD(1))+tand(beta1)*cotd(alpha)*(Coor(2)-Coor(2))/cotd(alpha)/cotd(beta1)/sqrt((CoorC(1)-CoorD(1))^2+(CoorC(2)-CoorD(2))^2);
theta = acosd(cosTheta);