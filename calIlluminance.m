%% 计算点的照度值计算
function illuminance = calIlluminance(CoordC, CoordD, alpha, beta)

%% 根据计算点，灯具坐标，灯具横向照明角度，灯具纵向照明角度，计算出theta角度，出射光线与灯轴夹角
theta1 = calTheta(CoorC,CoorD,alpha, beta);

%% 根据theta计算I(光强数据)
Itheta = calITheta(theta1);

%% 计算灯具坐标与计算点之间的距离l
l2 = (CoordC(1)-CoordD(1))^2+(CoordC(2)-CoordD(2))^2+(CoordC(3)-CoordD(3))^2;

%% 计算点的照度值
illuminance = Itheta/l2;
