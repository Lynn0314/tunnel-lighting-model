%%  根据计算点的Y轴坐标，计算相应灯具的index
function f = findDindex(YCoordinates, y)
%% 计算坐标小于给定值的数组中的index
f = max (find(YCoordinates < y));
end