function p=IN4(p)
 p.name='IN4';
 p.od = 3;
 p.pd = 10;
 range        = ones(p.pd,2);
 range(:,1)   = 0 ; 
 p.domain     =  range;
 p.func       = @evaluate;
    %IN1  evaluation function.
function ff = evaluate(x)  
    a               = 6.217210009329*10^(-2);
    b               = 6.666666666667*10^(-1);
    num             = size(x,2);
    Y               = zeros(p.pd,num);
    Y(3:p.pd,:)     = (x(3:p.pd,:) - repmat(x(1,:),[p.pd-2,1]).*sin(pi*repmat(x(2,:),[p.pd-2,1]))).^2;
    beta            = zeros(p.od,num);
    beta(1,:)       = sum(Y(3:3:p.pd,:),1);
    beta(2,:)       = sum(Y(4:3:p.pd,:),1);
    beta(3,:)       = sum(Y(5:3:p.pd,:),1);    
    alpha           = zeros(p.od,num);
    alpha(1,:)      = sin(pi/4).*(2*x(2,:)-1)+cos(pi/4).*(abs(2*x(2,:)-1)).^(x(1,:)+0.5);
    alpha(2,:)      = -cos(pi/4).*(2*x(2,:)-1)+sin(pi/4).*(abs(2*x(2,:)-1)).^(x(1,:)+0.5);
    alpha(3,:)      = 0;  
    origin          = zeros(p.od,num);
    origin(1,:)     = 2*x(1,:);
    origin(2,:)     = 2*x(1,:);
    origin(3,:)     = 0.2*cos(3*pi*(a+4*b*x(1,:)))-a+4*b*x(1,:);
    ff              = origin+alpha+beta;
end
end