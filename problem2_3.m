 i=0;
 A1_1=0;
 A2_1=zeros(11,1);
P1=(90*10^6*10)/(1+0.08);

for i=1:30
A1_1=1/((1+0.08)^i) + A1_1;
end


for j=1:11
for i=1:j
A2_1(j)=1/((1+0.08)^i) ;
end
end
disp("1-11:");
disp(A2_1);
disp(1./A1_1);