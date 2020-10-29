clc;clear;
sumj1=0;
sumj2=0;
sumj3=0;
sumj4=0;
A=cell(1,11);
for i=1:11
A{i}=zeros(4);
end
% 
% A{i}(i,:)=1;

for i=1:11
for j1=0:1
for j2=0:2
for j3=0:3
for j4=0:2      
    A{i}(1,j1+1)=j1;
    A{i}(2,j2+1)=j2;
    A{i}(3,j3+1)=j3;
    A{i}(4,j4+1)=j4;       
end
end
end
end
end

B=zeros(10000,4*11);
for j=1:100000
for i=1:11
for j1=0:1
for j2=0:2
for j3=0:3
for j4=0:2

    sumj1=sum(B(j,1:11));
    sumj2=sum(B(j,11:22));
    sumj3=sum(B(j,22:33));
    sumj4=sum(B(j,33:44));

    if(sumj1+j1<=3)&&(sumj2+j2<=6)&&(sumj3+j3<=10)&&(sumj4+j4<=10)
     B(j,i)=j1;
     B(j,11+i)=j2;
     B(j,22+i)=j3;
     B(j,33+i)=j4;    
    end  

    
end
end
end
end
end
end



