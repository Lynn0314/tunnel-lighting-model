%KNO1 function generator
function p=KNO1(p)
 p.name='KNO1';
 p.od = 2;      % dimension of objectives
 p.pd = 2;      % dimension of x
 p.domain= [0 3;0 3];   % search domain
 p.func = @evaluate;
 
    %KNO1 evaluation function.
    function y = evaluate(x)
      y=zeros(2,1);
	  c = x(1)+x(2);
	  %f = 9-(3*sin(2.5*c^0.5) + 3*sin(4*c) + 5 *sin(2*c+2));
      f = 9-(3*sin(2.5*c^2) + 3*sin(4*c) + 5 *sin(2*c+2));
	  g = (pi/2.0)*(x(1)-x(2)+3.0)/6.0;
	  y(1)= 20-(f*cos(g));
	  y(2)= 20-(f*sin(g)); 
    end
end