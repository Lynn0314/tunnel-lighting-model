function p=ZDT4(p)
 p.name='ZDT4';
 p.pd=10;
 p.od=2;
 aa=[-5*ones(10,1) 5*ones(10,1)];
 aa(1,1) = 0;
 aa(1,2) = 1;
 p.domain = aa;
 p.func=@evaluate;
 
    %KNO1 evaluation function.
    function y=evaluate(x)
    	xx = x(2:end);
        y=zeros(2,1);
        y(1) = x(1);
    	su = sum(xx.*xx - 10*cos(4*pi.*xx));   
		g = 1 + 10*9 + su;
		y(2) =g*(1 - sqrt(x(1) / g));
    end
end