%% 计算计算点亮度矩阵,输入参数为横向照明角度，纵向照明角度，灯具间距，安装高度，侧向中间距
function L = calLMatrix(alpha, beta,l,h,w,CPoints)

%% 亮度矩阵和计算点的数目一致 9*100
L= zeros(1,900);
numOfLamps = fix(100/l)+3;% 决定一个计算点亮度需要四盏灯
%% 两排灯具的坐标值
DlPoints = ones(3, numOfLamps);
DrPoints = ones(3, numOfLamps);
DlPoints(2,:) = 0:l:(numOfLamps-1)*l;
DrPoints(2,:) = 0:l:(numOfLamps-1)*l;
DlPoints(1, :) =  w .* DlPoints(2,:);
DrPoints(1, :) =  -w .* DrPoints(2,:);
DlPoints(3, :) =  h .* DlPoints(3,:);
DrPoints(3, :) =  h .* DrPoints(3,:);
%% 针对每一个计算点进行计算
for points = 1:100
    %% 灯具Y坐标，以及计算点的坐标，寻找第一个有影响的灯具y所在的index值
    index = findDindex(DlPoints(2,:),CPoints(2,points));
    for c9 = 1:9 %% 每9个计算点具有相同的Y值，具有相同的灯具影响
        indexCal = (points-1)*9+c9;
        CoorC = CPoints(:,indexCal);
        for lampsIndex = index:(index+3)
            %% 两个灯对计算点的亮度
            CoorD1 = DlPoints(:,lampsIndex);
            [tanGamma,beta1] = calQAngle(CoorC, CoorD1);
            q = calSimplifiedQ(tanGamma,beta1);
            L(indexCal) = L(indexCal)+ calIlluminance(CoorC,CoorD1,alpha, beta)*q;
            
            CoorD2 = DrPoints(:,lampsIndex);
            [tanGamma,beta2] = calQAngle(CoorC, CoorD2);
            q = calSimplifiedQ(tanGamma,beta2);
            L(indexCal) =L(indexCal)+ calIlluminance(CoorC,CoorD2,alpha, beta)*q;
        end
    end
    
end
