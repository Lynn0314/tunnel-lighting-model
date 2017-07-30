% cec09.m
% 
% The Matlab version of the test instances for CEC 2009 Multiobjective
%   Optimization Competition.
% 
% Usage: fobj = cec09(problem_name), the handle of the function will be
%   with fobj
% 
% Please refer to the report for correct one if the source codes are not
%   consist with the report.
% History:
%   v1 Sept.08 2008
%   v2 Nov.18  2008
%   v3 Nov.26  2008

function fobj=UF(testname,mop)

    switch testname
        case 'UF1'
            fobj = UF1(mop);
        case 'UF2'
            fobj = UF2(mop); 
        case 'UF3'
            fobj = UF3(mop);  
        case 'UF4'
            fobj = UF4(mop);
        case 'UF5'
            fobj = UF5(mop); 
        case 'UF6'
            fobj = UF6(mop);
        case 'UF7'
            fobj = UF7(mop);
        case 'UF8'
            fobj = UF8(mop); 
        case 'UF9'
            fobj = UF9(mop); 
        case 'UF10'
            fobj = UF10(mop);
                
        otherwise
          
    end
end

%% UF1
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF1(p)
 p.name='UF1';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
 function y = evaluate(x)
    [dim, num]  = size(x);
    tmp         = zeros(dim,num);
    tmp(2:dim,:)= (x(2:dim,:) - sin(6.0*pi*repmat(x(1,:),[dim-1,1]) + pi/dim*repmat((2:dim)',[1,num]))).^2;
    tmp1        = sum(tmp(3:2:dim,:));  % odd index
    tmp2        = sum(tmp(2:2:dim,:));  % even index
    y(1,:)      = x(1,:)             + 2.0*tmp1/size(3:2:dim,2);
    y(2,:)      = 1.0 - sqrt(x(1,:)) + 2.0*tmp2/size(2:2:dim,2);
    clear tmp;
 end
end

%% UF2
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF2(p)
 p.name='UF2';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]  = size(x);
    X1          = repmat(x(1,:),[dim-1,1]);
    A           = 6*pi*X1 + pi/dim*repmat((2:dim)',[1,num]);
    tmp         = zeros(dim,num);    
    tmp(2:dim,:)= (x(2:dim,:) - 0.3*X1.*(X1.*cos(4.0*A)+2.0).*cos(A)).^2;
    tmp1        = sum(tmp(3:2:dim,:));  % odd index
    tmp(2:dim,:)= (x(2:dim,:) - 0.3*X1.*(X1.*cos(4.0*A)+2.0).*sin(A)).^2;
    tmp2        = sum(tmp(2:2:dim,:));  % even index
    y(1,:)      = x(1,:)             + 2.0*tmp1/size(3:2:dim,2);
    y(2,:)      = 1.0 - sqrt(x(1,:)) + 2.0*tmp2/size(2:2:dim,2);
    clear X1 A tmp;
end
end

%% UF3
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF3(p)
 p.name='UF3';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
range(:,1)      =  0; 
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]   = size(x);
    Y            = zeros(dim,num);
    Y(2:dim,:)   = x(2:dim,:) - repmat(x(1,:),[dim-1,1]).^(0.5+1.5*(repmat((2:dim)',[1,num])-2.0)/(dim-2.0));
    tmp1         = zeros(dim,num);
    tmp1(2:dim,:)= Y(2:dim,:).^2;
    tmp2         = zeros(dim,num);
    tmp2(2:dim,:)= cos(20.0*pi*Y(2:dim,:)./sqrt(repmat((2:dim)',[1,num])));
    tmp11        = 4.0*sum(tmp1(3:2:dim,:)) - 2.0*prod(tmp2(3:2:dim,:)) + 2.0;  % odd index
    tmp21        = 4.0*sum(tmp1(2:2:dim,:)) - 2.0*prod(tmp2(2:2:dim,:)) + 2.0;  % even index
    y(1,:)       = x(1,:)             + 2.0*tmp11/size(3:2:dim,2);
    y(2,:)       = 1.0 - sqrt(x(1,:)) + 2.0*tmp21/size(2:2:dim,2);
    clear Y tmp1 tmp2;
end
end

%% UF4
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF4(p)
 p.name='UF4';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
range(1,1)      =  0;
range(2:p.pd,1)  = -2;
range(2:p.pd,2)  =  2;
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(2:dim,:)  = x(2:dim,:) - sin(6.0*pi*repmat(x(1,:),[dim-1,1]) + pi/dim*repmat((2:dim)',[1,num]));
    H           = zeros(dim,num);
    H(2:dim,:)  = abs(Y(2:dim,:))./(1.0+exp(2.0*abs(Y(2:dim,:))));
    tmp1        = sum(H(3:2:dim,:));  % odd index
    tmp2        = sum(H(2:2:dim,:));  % even index
    y(1,:)      = x(1,:)          + 2.0*tmp1/size(3:2:dim,2);
    y(2,:)      = 1.0 - x(1,:).^2 + 2.0*tmp2/size(2:2:dim,2);
    clear Y H;
end
end

%% UF5
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix

function p = UF5(p)
 p.name='UF5';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    N           = 10.0;
    E           = 0.1;
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(2:dim,:)  = x(2:dim,:) - sin(6.0*pi*repmat(x(1,:),[dim-1,1]) + pi/dim*repmat((2:dim)',[1,num]));
    H           = zeros(dim,num);
    H(2:dim,:)  = 2.0*Y(2:dim,:).^2 - cos(4.0*pi*Y(2:dim,:)) + 1.0;
    tmp1        = sum(H(3:2:dim,:));  % odd index
    tmp2        = sum(H(2:2:dim,:));  % even index
    tmp         = (0.5/N+E)*abs(sin(2.0*N*pi*x(1,:)));
    y(1,:)      = x(1,:)      + tmp + 2.0*tmp1/size(3:2:dim,2);
    y(2,:)      = 1.0 - x(1,:)+ tmp + 2.0*tmp2/size(2:2:dim,2);
    clear Y H;
end
end

%% UF6
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix

function p = UF6(p)
 p.name='UF6';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    N            = 2.0;
    E            = 0.1;
    [dim, num]   = size(x);
    Y            = zeros(dim,num);
    Y(2:dim,:)  = x(2:dim,:) - sin(6.0*pi*repmat(x(1,:),[dim-1,1]) + pi/dim*repmat((2:dim)',[1,num]));
    tmp1         = zeros(dim,num);
    tmp1(2:dim,:)= Y(2:dim,:).^2;
    tmp2         = zeros(dim,num);
    tmp2(2:dim,:)= cos(20.0*pi*Y(2:dim,:)./sqrt(repmat((2:dim)',[1,num])));
    tmp11        = 4.0*sum(tmp1(3:2:dim,:)) - 2.0*prod(tmp2(3:2:dim,:)) + 2.0;  % odd index
    tmp21        = 4.0*sum(tmp1(2:2:dim,:)) - 2.0*prod(tmp2(2:2:dim,:)) + 2.0;  % even index
    tmp          = max(0,(1.0/N+2.0*E)*sin(2.0*N*pi*x(1,:)));
    y(1,:)       = x(1,:)       + tmp + 2.0*tmp11/size(3:2:dim,2);
    y(2,:)       = 1.0 - x(1,:) + tmp + 2.0*tmp21/size(2:2:dim,2);
    clear Y tmp1 tmp2;
end
end

%% UF7
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF7(p)
 p.name='UF7';
 p.od = 2;
 p.pd = 30;
 range = ones(p.pd,2); 
 range(1,1)      =  0;
 range(2:p.pd,1)  = -1;
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(2:dim,:)  = (x(2:dim,:) - sin(6.0*pi*repmat(x(1,:),[dim-1,1]) + pi/dim*repmat((2:dim)',[1,num]))).^2;
    tmp1        = sum(Y(3:2:dim,:));  % odd index
    tmp2        = sum(Y(2:2:dim,:));  % even index
    tmp         = (x(1,:)).^0.2;
    y(1,:)      = tmp       + 2.0*tmp1/size(3:2:dim,2);
    y(2,:)      = 1.0 - tmp + 2.0*tmp2/size(2:2:dim,2);
    clear Y;
end
end

%% UF8
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF8(p)
 p.name='UF8';
 p.od = 3;
 p.pd = 30;
 range = ones(p.pd,2); 
range(1:2,1)    =  0;
range(3:p.pd,1)  = -2;
range(3:p.pd,2)  =  2; 
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(3:dim,:)  = (x(3:dim,:) - 2.0*repmat(x(2,:),[dim-2,1]).*sin(2.0*pi*repmat(x(1,:),[dim-2,1]) + pi/dim*repmat((3:dim)',[1,num]))).^2;
    tmp1        = sum(Y(4:3:dim,:));  % j-1 = 3*k
    tmp2        = sum(Y(5:3:dim,:));  % j-2 = 3*k
    tmp3        = sum(Y(3:3:dim,:));  % j-0 = 3*k
    y(1,:)      = cos(0.5*pi*x(1,:)).*cos(0.5*pi*x(2,:)) + 2.0*tmp1/size(4:3:dim,2);
    y(2,:)      = cos(0.5*pi*x(1,:)).*sin(0.5*pi*x(2,:)) + 2.0*tmp2/size(5:3:dim,2);
    y(3,:)      = sin(0.5*pi*x(1,:))                     + 2.0*tmp3/size(3:3:dim,2);
    clear Y;
end
end

%% UF9
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF9(p)
 p.name='UF9';
 p.od = 3;
 p.pd = 30;
 range = ones(p.pd,2); 
range(1:2,1)    =  0;
range(3:p.pd,1)  = -2;
range(3:p.pd,2)  =  2; 
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    E           = 0.1;
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(3:dim,:)  = (x(3:dim,:) - 2.0*repmat(x(2,:),[dim-2,1]).*sin(2.0*pi*repmat(x(1,:),[dim-2,1]) + pi/dim*repmat((3:dim)',[1,num]))).^2;
    tmp1        = sum(Y(4:3:dim,:));  % j-1 = 3*k
    tmp2        = sum(Y(5:3:dim,:));  % j-2 = 3*k
    tmp3        = sum(Y(3:3:dim,:));  % j-0 = 3*k
    tmp         = max(0,(1.0+E)*(1-4.0*(2.0*x(1,:)-1).^2));
    y(1,:)      = 0.5*(tmp+2*x(1,:)).*x(2,:)     + 2.0*tmp1/size(4:3:dim,2);
    y(2,:)      = 0.5*(tmp-2*x(1,:)+2.0).*x(2,:) + 2.0*tmp2/size(5:3:dim,2);
    y(3,:)      = 1-x(2,:)                       + 2.0*tmp3/size(3:3:dim,2);
    clear Y;
end
end

%% UF10
% x and y are columnwise, the imput x must be inside the search space and
% it could be a matrix
function p = UF10(p)
 p.name='UF10';
 p.od = 3;
 p.pd = 30;
 range = ones(p.pd,2); 
range(1:2,1)    =  0;
range(3:p.pd,1)  = -2;
range(3:p.pd,2)  =  2; 
 p.domain=  range;
 p.func = @evaluate;
function y = evaluate(x)
    [dim, num]  = size(x);
    Y           = zeros(dim,num);
    Y(3:dim,:)  = x(3:dim,:) - 2.0*repmat(x(2,:),[dim-2,1]).*sin(2.0*pi*repmat(x(1,:),[dim-2,1]) + pi/dim*repmat((3:dim)',[1,num]));
    H           = zeros(dim,num);
    H(3:dim,:)  = 4.0*Y(3:dim,:).^2 - cos(8.0*pi*Y(3:dim,:)) + 1.0;
    tmp1        = sum(H(4:3:dim,:));  % j-1 = 3*k
    tmp2        = sum(H(5:3:dim,:));  % j-2 = 3*k
    tmp3        = sum(H(3:3:dim,:));  % j-0 = 3*k
    y(1,:)      = cos(0.5*pi*x(1,:)).*cos(0.5*pi*x(2,:)) + 2.0*tmp1/size(4:3:dim,2);
    y(2,:)      = cos(0.5*pi*x(1,:)).*sin(0.5*pi*x(2,:)) + 2.0*tmp2/size(5:3:dim,2);
    y(3,:)      = sin(0.5*pi*x(1,:))                     + 2.0*tmp3/size(3:3:dim,2);
    clear Y H;
end
end
