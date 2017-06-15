%% �������ն�ֵ����
function illuminance = calIlluminance(CoordC, CoordD, alpha, beta)

%% ���ݼ���㣬�ƾ����꣬�ƾߺ��������Ƕȣ��ƾ����������Ƕȣ������theta�Ƕȣ�������������н�
theta1 = calTheta(CoorC,CoorD,alpha, beta);

%% ����theta����I(��ǿ����)
Itheta = calITheta(theta1);

%% ����ƾ�����������֮��ľ���l
l2 = (CoordC(1)-CoordD(1))^2+(CoordC(2)-CoordD(2))^2+(CoordC(3)-CoordD(3))^2;

%% �������ն�ֵ
illuminance = Itheta/l2;
