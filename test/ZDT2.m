function p=ZDT2(p)
 p.name='ZDT2';
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
		y(2) =g*(1 - (x(1) / g).^2);
    end
end