function value=Deltap_test(val_cp,val_p)
    [dim_f1,num_cp] = size(val_cp);
    [dim_f2,num_p]  = size(val_p);
    value1 = 0;
    value2 = 0;
    if dim_f1 == dim_f2
        for i=1:num_cp
            dis=sqrt(sum((repmat(val_cp(:,i),[1,num_p])-val_p).^2,1));
            val=min(dis);
            value1=value1+(val).^2;
        end
        value1=(value1/num_cp).^(1/2);
        
        for i=1:num_p
            dis=sqrt(sum((repmat(val_p(:,i),[1,num_cp])-val_cp).^2,1));
            val=min(dis);
            value2=value2+(val).^2;
        end
        value2=(value2/num_cp).^(1/2);
        
        value = max(value1,value2);
    else
        disp('the dimension of two stes is not equal!');
    end
end
