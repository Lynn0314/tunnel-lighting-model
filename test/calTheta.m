function theta = calTheta(CoorC,CoorD,alpha, beta1,flag)
if(flag==1)
    cosTheta = (CoorD(3)+ tand(alpha)*(CoorC(1)-CoorD(1))+tand(beta1)*secd(alpha)*(CoorC(2)-CoorD(2)))/secd(alpha)/secd(beta1)/sqrt((CoorC(1)-CoorD(1))^2+(CoorC(2)-CoorD(2))^2+CoorD(3)*CoorD(3));
elseif(flag==0)
    cosTheta = (CoorD(3)- tand(alpha)*(CoorC(1)-CoorD(1))+tand(beta1)*secd(alpha)*(CoorC(2)-CoorD(2)))/secd(alpha)/secd(beta1)/sqrt((CoorC(1)-CoorD(1))^2+(CoorC(2)-CoorD(2))^2+CoorD(3)*CoorD(3));
end

theta = acosd(cosTheta);