function state=stateOutput(state,params,pop,mop,nrun)
    if params.isDebug==1||~state.stopCriterion                 
        gen  = state.currentGen;
        if (gen>0&&gen<11)||(mod(gen,10)==0&&gen<100)||(mod(gen,100)==0)||~state.stopCriterion
        % 当前种群的自变量与目标函数值
            if isempty(state.archive)
                individual    = [pop.inter];
                valf          = [individual.objective];
                valx          = [individual.parameter];
            else
                individual    = [state.archive];
                valf          = [individual.objective];
                valx          = [individual.parameter];
            end
%             valf2          = [individual.objective2];
%             valf3          = [individual.objective3];

            %输出当前状态
            output(valf,valx,nrun,params,mop,state);
       end
    end
end






function output(val_f,val_x,nrun,params,mop,state)
    name         = mop.name;


%% 保存当前的和最后的种群自变量的值
%     if ~state.stopCriterion 
        file      = val_x';
        filename  = strcat('PS_',name,'_R',num2str(nrun),'gen',num2str(state.currentGen)); 
        filetype  = 'dat';
        folder    = 'PS_data\z1';
        mySave(file,filename,filetype,folder)
%     end
%% 保存当前的和最后的种群自变量的值
%     if ~state.stopCriterion 
        file      = val_f';
        filename  = strcat('PF_',name,'_R',num2str(nrun),'gen',num2str(state.currentGen)); 
%         filename2  = strcat('2PF_',name,'_R',num2str(nrun),'gen',num2str(state.currentGen)); 
%         filename3  = strcat('3PF_',name,'_R',num2str(nrun),'gen',num2str(state.currentGen)); 
        filetype  = 'dat';
        folder    = 'PF_data\z1';
%         folder2    = 'PF_data\z2';
%         folder3    = 'PF_data\z3';
        mySave(file,filename,filetype,folder);

        
    val_f = val_f( :, val_f(1,:) <= 1);
    val_x = val_x( :, val_f(1,:) <= 1);

%     end

%     
% %% 最后作图时删除劣解
%     if ~state.stopCriterion
%         [val_dim,num_p]  = size(val_f);
%         rank             = zeros(1,num_p);
%         for k=1:num_p
%             for j=k+1:num_p
%                     if all(val_f(:,j)<=val_f(:,k))
%                         rank(k)  = rank(k)+1;
%                     elseif all(val_f(:,k)<=val_f(:,j))
%                         rank(j)  = rank(j)+1;
%                     end
%             end
%         end
%         val_f(:,rank~=0)=[];
%     end

%% 做有效界面图像
    close;
    H=figure(1);
   
    
%% 做有效点的图像  
    
    dim_f     = size(val_f,1);
    
    if dim_f == 2 
        plot(-val_f(1,:),val_f(2,:),'MarkerFaceColor',[0.502 0.502 0.502],...
               'MarkerEdgeColor',[0.3137 0.3137 0.3137],...
               'MarkerSize',10,...
               'Marker','o','LineStyle','none'); 
        hold off;
        xlabel('f1','FontWeight','bold','FontSize',20,'FontName','High Tower Text','Rotation',0);
        ylabel('f2','FontWeight','bold','FontSize',20,'FontName','High Tower Text');
        title(state.currentGen,'FontWeight','bold','FontSize',20);
        axis([0,1,0,900]);
        box off;
    else
        plot3(val_f(1,:),val_f(2,:),val_f(3,:),'MarkerFaceColor',[0.502 0.502 0.502],...
               'MarkerEdgeColor',[0.3137 0.3137 0.3137],...
               'MarkerSize',10,...
               'Marker','o','LineStyle','none'); 
        axis([0,1.01,0,1.01,0,1.01]);
        grid off
        hold off;
        xlabel('f1','FontWeight','bold','FontSize',20,'FontName','High Tower Text');
        ylabel('f2','FontWeight','bold','FontSize',20,'FontName','High Tower Text');
        zlabel('f3','FontWeight','bold','FontSize',20,'FontName','High Tower Text');
        title(state.currentGen,'FontWeight','bold','FontSize',20);
    end
    drawnow
    % 保存图像
    if ~state.stopCriterion ||  ( strcmpi(params.resultOut, 'save'))
        file = H;
        filename = strcat('FIG_',name,'_R',num2str(nrun),'gen',num2str(state.currentGen));
        filetype = 'fig';
        folder   = 'fig_data\z1';
        mySave(file,filename,filetype,folder)
    end
end

function mySave(file,filename,filetype,folder)
    name      = strcat(filename,'.',filetype);
    if ( strcmpi(filetype, 'dat'))
        fid       = fopen(name,'w');
        [numline,numi]   = size(file);
        for i=1:numline
            for j=1:numi
                fprintf(fid,'%8.6f ',file(i,j));
            end
            fprintf(fid,'\n');
        end
        fclose(fid);
    elseif  ( strcmpi(filetype, 'fig'))
        saveas(file,name);
    end
    judge     = exist(folder);
    if judge ~= 7
        system(['mkdir ', folder]);
    end
    file_path = strcat(cd,'\',folder);
    movefile(name,file_path); 
end