function [val_w,val_cp] = assign()
    global params,global mop;
    val_w    = weight1(params.popsize,mop.od);
    val_w    = val_w./repmat(sqrt(sum(val_w.^2)),[mop.od,1]);
    
    val_cp   = weight1(params.num_class,mop.od);  
    val_cp   = val_cp./repmat(sqrt(sum(val_cp.^2)),[mop.od,1]);
end


function val_w = weight1 (popsize,objDim)
    
    if objDim==2
        start      = 1/(popsize*100000);
        val_w(1,:) = linspace(start,1-start,popsize);
        val_w(2,:) = ones(1,popsize)-val_w(1,:);
    elseif objDim==3
        val_w     = assign3(popsize,1);
    elseif objDim==4
        val_w          = zeros(objDim,popsize); 
        [numplane,numpoint]=comline3(popsize);
        start      = 1/(numplane*10);
        val_one    = linspace(start,1-start,numplane);
        reg        = 1;
        for i=1:numplane
            nump   = numpoint(numplane-i+1);
            if nump>1
                val    = zeros(4,nump);
                sideL  = 1-val_one(i);
                val(1:3,:)=assign3(nump,sideL);
                val(4,:)=val_one(i);
            else
                val    = zeros(4,nump);
                val(1)=(1-val_one(i))/2;
                val(2)=(1-val_one(i))/2;
                val(3)=(1-val_one(i))/2;
                val(4)=val_one(i);
            end
            val_w(:,reg:reg+nump-1)=val;
            reg=reg+nump;
        end
    end
end

function val_w = assign3(popsize,sideL) 
     val_w          = zeros(3,popsize);   
     [numline,numpoint]=comline2(popsize);
     start      = sideL/(numline*10);
     val_one    = linspace(start,sideL-start,numline);
     reg        = 1;
     for i=1:numline
         nump   = numpoint(numline-i+1);
         if nump>1
             val    = zeros(3,nump);
             Lline  = sideL-val_one(i);
             lstart = Lline/(10*nump);
             val(1,:)=linspace(lstart,Lline-lstart,nump);
             val(2,:)=Lline-val(1,:);
             val(3,:)=val_one(i);
         else
             val    = zeros(3,nump);
             val(1)=(sideL-val_one(i))/2;
             val(2)=(sideL-val_one(i))/2;
             val(3)=val_one(i);
         end
         val_w(:,reg:reg+nump-1)=val;
         reg=reg+nump;
     end
end

function [numline,numpoint]=comline2(popsize)
    numline    = round((sqrt(popsize*8+1)-1)/2);
    numpoint   = 1:numline;
    vp         = (numline+1)*numline/2;
    disnum     = popsize-vp;
    numpoint(numline-abs(disnum)+1:numline)=numpoint(numline-abs(disnum)+1:numline)+sign(disnum)*ones(1,abs(disnum));  
end


function [numplane,numpoint]=comline3(popsize)
    numplane   = ceil(1/6*(324*popsize+3*(-3+11664*popsize^2)^(1/2))^(1/3)+1/2/(324*popsize+3*(-3+11664*popsize^2)^(1/2))^(1/3)-1/2);
    numpoint   = (1:numplane).^2;
    vp         = (numplane)*(numplane-1)*(2*numplane-1)/6;
    disnum     = popsize-vp;
    numpoint(numplane)=disnum;  
end


function val_p      = weight2(num_div,dim_f)
    val_rad         = radvalue(num_div,dim_f);
    num_pop         = size(val_rad,2);
    val_p           = zeros(dim_f,num_pop);
    for i = 1:dim_f-1
        val_p(1,:)  = cos(val_rad(1,:));
    end
    for i = 2:dim_f-1
        val_p(i,:)  = ((val_p(i-1,:).*sin(val_rad(i-1,:))).*cos(val_rad(i,:)))./cos(val_rad(i-1,:));
    end
    val_p(dim_f,:)  = (val_p(dim_f-1,:).*sin(val_rad(dim_f-1,:)))./cos(val_rad(dim_f-1,:));
    clear dim_f i val_rad;
end
    

function val_rad = radvalue(num_div,dim_f)
    unit        = pi/(2*num_div);
    if dim_f   == 2
        val_rad = radunif(1,unit);
    elseif dim_f > 2
        rad     = radunif(1,unit);
        val_rad = radget(rad,unit,dim_f);
        clear rad;
    else
        disp('The dimension of mutiobject is wrong!');
    end
    clear num_div dim_f;
end

function radian = radget(rad,unit,dim_f)
    if dim_f > 2
        [dim_rad,len_rad] = size(rad);
        fix_len           = round((len_rad^2)/2);
        radian            = zeros(dim_rad+1,fix_len);
        reg               = 1;
        radius            = prod(sin(rad),1);
        for i = 1:len_rad
            tmp_rad                             = radunif(radius(i),unit);
            tmp_len                             = length(tmp_rad);
            radian(1:dim_rad,reg:reg+tmp_len-1) = repmat(rad(:,i),[1,tmp_len]);
            radian(dim_rad+1,reg:reg+tmp_len-1) = tmp_rad;
            reg                                 = reg+tmp_len;
            clear tmp_rad;
        end
        radian(:,reg:fix_len) = [];
        clear rad dim_rad len_rad reg i tmp_len fix_len;
        dim_f                   = dim_f-1;
        if dim_f > 2;
            radian = radget(radian,unit,dim_f);  
        else
            clear dim_f unit;
        end
    end
end
  

function rad = radunif(radius,unit)
    num_rad  = ceil(radius*pi/(2*unit));
    rad      = pi*(1:2:2*num_rad)/(4*num_rad); 
    clear radius unit num_rad;
end
 






