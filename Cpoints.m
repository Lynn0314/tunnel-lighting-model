function cpoints = Cpoints()
k=1;
%% 计算点，纵向100个，1m一个，横向，每车道有三个，共三车道，计算点距离为1m
Yc = zeros(3,900);

%%  计算点的坐标信息，第一行Y坐标，第二行X坐标，第三行为Z坐标
for  j=0.5:1:100
    for i = -4:1:4
        Yc(2,k)=j;
        Yc(1,k)=i;
        k = k+1;
    end
end
cpoints = Yc;
