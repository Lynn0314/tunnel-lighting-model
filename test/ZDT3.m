function p=ZDT3(p)
 p.name='ZDT3';
 p.pd=30;
 p.od=2;
 p.domain=[zeros(30,1) ones(30,1)];
 p.func=@evaluate;
 
    %KNO1 evaluation function.
    function y=evaluate(x)
        y=zeros(2,1);
        y(1) = x(1);
    	su = sum(x)-x(1);    
		g = 1 + 9 * su / (30 - 1);
		y(2) =g*(1 - sqrt(x(1) / g) - x(1)*sin(10*pi*x(1))/g);
    end
end