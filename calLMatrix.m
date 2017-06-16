%% �����������Ⱦ���,�������Ϊ���������Ƕȣ����������Ƕȣ��ƾ߼�࣬��װ�߶ȣ������м��
function L = calLMatrix(alpha, beta,l,h,w,CPoints)

%% ���Ⱦ���ͼ�������Ŀһ�� 9*100
L= zeros(1,900);
numOfLamps = fix(100/l)+3;% ����һ�������������Ҫ��յ��
%% ���ŵƾߵ�����ֵ
DlPoints = ones(3, numOfLamps);
DrPoints = ones(3, numOfLamps);
DlPoints(2,:) = 0:l:(numOfLamps-1)*l;
DrPoints(2,:) = 0:l:(numOfLamps-1)*l;
DlPoints(1, :) =  w .* DlPoints(2,:);
DrPoints(1, :) =  -w .* DrPoints(2,:);
DlPoints(3, :) =  h .* DlPoints(3,:);
DrPoints(3, :) =  h .* DrPoints(3,:);
%% ���ÿһ���������м���
for points = 1:100
    %% �ƾ�Y���꣬�Լ����������꣬Ѱ�ҵ�һ����Ӱ��ĵƾ�y���ڵ�indexֵ
    index = findDindex(DlPoints(2,:),CPoints(2,points));
    for c9 = 1:9 %% ÿ9������������ͬ��Yֵ��������ͬ�ĵƾ�Ӱ��
        indexCal = (points-1)*9+c9;
        CoorC = CPoints(:,indexCal);
        for lampsIndex = index:(index+3)
            %% �����ƶԼ���������
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
