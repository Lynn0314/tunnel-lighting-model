function p=F3(p)
 p.name='F3';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
    %F3  evaluation function.
    function y = evaluate(x)
      [dim, num]  = size(x);
      tmp         = zeros(dim,num);
      loc         = 3:2:dim;
      tmp(loc,:)  = x(loc,:) - 0.8*repmat(x(1,:),[length(loc),1]).*cos(6.0*pi*repmat(x(1,:),[length(loc),1]) + pi/dim*repmat(loc',[1,num]));
      loc         = 2:2:dim;
      tmp(loc,:)  = x(loc,:) - 0.8*repmat(x(1,:),[length(loc),1]).*sin(6.0*pi*repmat(x(1,:),[length(loc),1]) + pi/dim*repmat(loc',[1,num]));
      tmp1        = 2.0*sum(tmp(3:2:dim,:).^2);  % odd index   
      tmp2        = 2.0*sum(tmp(2:2:dim,:).^2);  % even index  
      y(1,:)      = x(1,:)  + tmp1/size(3:2:dim,2);
      y(2,:)      = 1.0 - sqrt(x(1,:))+ tmp2/size(2:2:dim,2);
      clear tmp;
    end
end