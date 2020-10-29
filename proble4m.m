clc;clear;


r_nmt=[
4.5 
7.3 
9.2 
9.1 
8.0 
7.6 
];
Time_recover=[40
50
50
40
150
100
];

M_num=[
4
3
3
4
2
1
];

power=[76
100
197
155
400
350
];

M_power=zeros(17,1);
u_recove=8760./Time_recover;

PA_U=zeros(9,2);
PU_A=zeros(17,2);

for i=1:6
PA_U(i,1)=u_recove(i)/(r_nmt(i)+u_recove(i));%A
PA_U(i,2)=r_nmt(i)/(r_nmt(i)+u_recove(i));%U
end
for i=1:6
    for j=1:M_num(i)
        PU_A(sum(M_num(1:i-1))+j,1)=PA_U(i,1);
        PU_A(sum(M_num(1:i-1))+j,2)=PA_U(i,2);
    end
end

for i=1:6
    for j=1:M_num(i)
        M_power(sum(M_num(1:i-1))+j)=power(i);
    end
end


man = matGen(8);
% p=[1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1,1,0,1,0,1,1,0,1];
% p=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
% p=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
m=0;
p=ff2n(17);
XSUM=ones(131072,2);
XSUM(:,2)=zeros(131072,1);
%1==PA,0==PU
for j=1:131072
    
    for i=1:17
    if p(j,i)==0
        m=PU_A(i,2); 
    end
     if p(j,i)==1
        m=PU_A(i,1);
        XSUM(j,2)=M_power(i)+XSUM(j,2);
     end
    XSUM(j,1)=m*XSUM(j,1); 
    end

end
i=1;
% hege=ones(131072,2);
for j=1:131072
    if XSUM(j,2)<2182
       hege(i,1)= XSUM(j,1);
       hege(i,2)=2182-XSUM(j,2); 
      i=i+1;  
    end
end
P1=sum(hege(:,1))
P2=sum(XSUM(:,1));
hege(:,3)=hege(:,2).*hege(:,1);
SUM_POWER=sum(hege(:,3));
SUM_POWER=SUM_POWER*8760