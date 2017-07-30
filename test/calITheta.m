%% 根据输入的theta值计算相应的光强
function I = calITheta(theta)
Phi = 4144;
thetas = 0:5:90;
Is=[284 279.96 276.56 270.64 262.4 249.64 235.84 219.32 199.24 177.32 152.96 127.48 101.76 76.76 53.8 35.48 21.672 12.784 7.2];
I = interp1(thetas,Is,theta,'spline')*Phi/10000;