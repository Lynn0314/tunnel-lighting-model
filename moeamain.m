
%% 测试函数集合
clear; close; clc;                            %  1-7 
name_func = {'light'};
    %% 算法初始化
global cpoints;
cpoints = Cpoints();

seq_num = length(name_func);
run = 1;
% seq_num = 1;
lp = 50;

    for seq =1:1
        seq
        dp = [];
        igd = [];
        h = [];
        time = [];
        for nrun=1:run
            tic
            nrun
           
            name_f   = char(name_func(seq));
%             seed     = 60+nrun;randn('state',seed);rand('state',seed);
            state    = get_structure( 'state');
            params   = get_structure( 'parameter');
            [params,mop,pop,CMpara]=inputparams(name_f,params);
            [params,mop,pop,state]=initialize(params,mop,pop,state); 
           % gl = (params.iteration/(params.popsize));
            my = zeros(params.num_class,1);
            pos = zeros(params.num_class,1);
            hash = zeros(1,params.num_class);
        
          
            while state.stopCriterion 
                [params,mop,pop,state]=evolution(params,mop,pop,state,CMpara);
                % 当前状态输出
                state=stateOutput(state,params,pop,mop,nrun);
                fprintf('gen =   %d\n run = %d\n',state.currentGen, nrun);           
                state.currentGen=state.currentGen+1;
                % 检测是否终止
                state  = checkstop(params,state);
            end
            state=stateOutput(state,params,pop,mop,nrun);
            endt = toc
            time = [time,endt];

        end
        filename = [name_func{seq},'_',num2str(nrun),'_evaluation.mat'];
    
    end