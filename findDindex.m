%%  ���ݼ�����Y�����꣬������Ӧ�ƾߵ�index
function f = findDindex(YCoordinates, y)
%% ��������С�ڸ���ֵ�������е�index
f = max (find(YCoordinates < y));
end