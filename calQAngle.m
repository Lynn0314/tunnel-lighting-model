%% ���������ϵ���������Ƕȣ����������Լ��۲����������ļн�beta
function [tanGamma,beta] = calQAngle(CoorC, CoorD)
CoorQ = [0,-60,0]; %% �۲�������ֵ����ƽ���ϵ�ͶӰ��ʵ�ʼ�����1.5m�ߣ�
CoorB = [CoorD(1),CoorD(2),0];
tanGamma = sqrt((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2)))/CoorD(3);
cosBeta = ((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2))^2+(CoorC(1)-CoorQ(1))^2+(CoorC(2)-CoorQ(2))^2-(CoorQ(1)-CoorB(1))^2-(CoorQ(2)-CoorB(2))^2)/2/sqrt((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2))^2)/sqrt((CoorC(1)-CoorQ(1))^2+(CoorC(2)-CoorQ(2))^2);
beta = rad2deg(acos(cosBeta));