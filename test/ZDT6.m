function p=ZDT6(p)
 p.name='ZDT6';
 p.pd=10;
 p.od=2;
 p.domain=[zeros(10,1) ones(10,1)];
 p.func=@evaluate;
 
    %KNO1 evaluation function.
    function y=evaluate(x)
        y=zeros(2,1);
        y(1) = 1 - exp(-4*x(1))*(sin(6*pi*x(1))).^6;
    	su = sum(x)-x(1);    
		g = 1 + 9 * (su / (10 - 1)).^0.25;   
		y(2) =g*(1 - (y(1) / g).^2);
    end
end