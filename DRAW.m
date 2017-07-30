
clc

% mop4_igd = xlsread('data', 'A18:AV18');
% mop4_h = xlsread('data', 'A20:AV20');
% 
% mop4_igd_10 = xlsread('data', 'A1:AV1');
% mop4_igd_25 = xlsread('data', 'A2:AV2');
% mop4_igd_50 = xlsread('data', 'A3:AV3');
% mop4_igd_75 = xlsread('data', 'A4:AV4');
% 
% mop4_h_10 = xlsread('data', 'A10:AV10');
% mop4_h_25 = xlsread('data', 'A11:AV11');
% mop4_h_50 = xlsread('data', 'A12:AV12');
% mop4_h_75 = xlsread('data', 'A13:AV13');

line = {'r*-','b+-','g+-','m*-','k'};

mop4_igd_cell = {mop4_igd, mop4_igd_10, mop4_igd_25, mop4_igd_50, mop4_igd_75};
mop4_h_cell = {mop4_h, mop4_h_10, mop4_h_25, mop4_h_50, mop4_h_75};

x = xlsread('data','A17:AV17');
x = [0,x,3000,3000];
for i = 2:5
    plot(  mop4_igd_cell{i}, line{i})
    hold on
end
 set(gca,'xtick',0:6:48)
 set(gca,'xticklabel',x(1:6:49))
%  xlim([0 48])
 