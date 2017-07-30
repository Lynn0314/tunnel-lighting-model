clear
name1 = {'F1','F2','F3','F4','F5','F6','F7','F8','F9'};
for i  = 1:length(name1)
    filename = [name1{i},'_30_evaluation.mat'];
    n = name1{i};
    label =  n(regexp(n, '\d'));
    label = ['A',label];
    load(filename)
    xlswrite('function',igd,'MY-F-IGD',label)
    xlswrite('function',dp,'MY-F-DP',label)
    xlswrite('function',h,'MY-F-h',label)
end
name = {'UF1','UF2','UF3','UF4','UF5','UF6','UF7','UF8','UF9','UF10'};
for i  = 1:length(name)
    filename = [name{i},'_30_evaluation.mat'];
    n = name{i};
    label =  n(regexp(n, '\d'));
    label = ['A',label];
    load(filename)
    xlswrite('function',igd,'MY-UF-IGD',label)
    xlswrite('function',dp,'MY-UF-DP',label)
    xlswrite('function',h,'MY-UF-h',label)
end