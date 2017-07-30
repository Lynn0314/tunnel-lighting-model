function p=F7(p)
 p.name='F7';
 p.od = 2;
 p.pd = 10;
 range = ones(p.pd,2); 
 range(:,1)      =  0;
 p.domain=  range;
 p.func = @evaluate;
    %F7  evaluation function.
    function y = evaluate(x)
        [dim, num]   = size(x);
        Y            = zeros(dim,num);
        Y(2:dim,:)   = x(2:dim,:) - repmat(x(1,:),[dim-1,1]).^(0.5+1.5*(repmat((2:dim)',[1,num])-2.0)/(dim-2.0));
        tmp1         = zeros(dim,num);
        tmp1(2:dim,:)= Y(2:dim,:).^2;
        tmp2         = zeros(dim,num);
        tmp2(2:dim,:)= cos(8.0*pi*Y(2:dim,:));
        tmp11        = 4.0*sum(tmp1(3:2:dim,:)) - sum(tmp2(3:2:dim,:)- 1.0) ;  % odd index
        tmp21        = 4.0*sum(tmp1(2:2:dim,:)) - sum(tmp2(2:2:dim,:)- 1.0) ;  % even index
        y(1,:)       = x(1,:)             + 2.0*tmp11/size(3:2:dim,2);
        y(2,:)       = 1.0 - sqrt(x(1,:)) + 2.0*tmp21/size(2:2:dim,2);
        clear Y tmp1 tmp2;
    end
end