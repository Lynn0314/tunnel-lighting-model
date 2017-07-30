function p=IN2(p)
 p.name='IN2';
 p.od = 3;
 p.pd = 10;
 range        = ones(p.pd,2);
 range(:,1)   = 0 ; 
 p.domain     =  range;
 p.func       = @evaluate;
    %IN1  evaluation function.
function ff = evaluate(x)   
    num             = size(x,2);
    Y               = zeros(p.pd,num);
    Y(3:p.pd,:)     = (x(3:p.pd,:) - repmat(x(2,:),[p.pd-2,1]).*sin(2.0*pi*repmat(x(1,:),[p.pd-2,1]))).^2;
    beta            = zeros(p.od,num);
    beta(1,:)       = sum(Y(3:3:p.pd,:),1);
    beta(2,:)       = sum(Y(4:3:p.pd,:),1);
    beta(3,:)       = sum(Y(5:3:p.pd,:),1);    
    alpha           = zeros(3,num);
    alpha(1,:)      = cos(pi/4).*(2*x(2,:)-1)+sin(pi/4).*(2*x(2,:)-1).^2.*(x(1,:)-0.5);
    alpha(2,:)      = -sin(pi/4).*(2*x(2,:)-1)+cos(pi/4).*(2*x(2,:)-1).^2*(x(1,:)-0.5);
    alpha(3,:)      = 0;        
    origin          = zeros(p.od,num);
    origin(1,:)     = x(1,:);
    origin(2,:)     = x(1,:);
    origin(3,:)     = -(2*x(1,:)-1).^3;
    ff(1:3,:)       = origin+alpha+beta;

end
end