%分区域方法
function team = group(params, pop, nornal_obj)
    tmp = nornal_obj(2,:);
    nornal_obj(2,:) = tmp/max(tmp);
    team              = cell(params.num_class,1);
    num_p             = size(nornal_obj,2); % 列数
    center            = [pop.center];
    dis               = center'*nornal_obj;  
    [minval,minindex] = max(dis,[],1);
    for i = 1:num_p
        team{minindex(i)}   = [team{minindex(i)},i];
    end
end
