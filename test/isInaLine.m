function flag = isInaLine(CoorC, CoorB, CoorQ)
bc = sqrt((CoorC(1)-CoorB(1))^2+(CoorC(2)-CoorB(2))^2)
cq = sqrt((CoorC(1)-CoorQ(1))^2+(CoorC(2)-CoorQ(2))^2)
bq = sqrt((CoorQ(1)-CoorB(1))^2+(CoorQ(2)-CoorB(2))^2)

if(bc + cq <=bq || bc+bq <=cq||cq+bq<=bc)
    flag = 1;
else
    flag = 0;
end