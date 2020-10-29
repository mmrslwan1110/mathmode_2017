% % 
clc; clear;
% f=[-5; -4; -6];
% A =[1 -1  1;3 2  4;3  2  0];
% b=[20; 42; 30],lb=zeros(3,1);
% % [x,fval,exitflag,output,lambda]=linprog(f,A,b,Aeq,beq,lb,ub);
% [x,fval,exitflag,output,lambda]=linprog(f,A,b,[],[],lb)

a=[0.064
0.014
0.053
0.007
0.328
0.008
0.001
0.023
0.005
0.008
0.042
0.054
0.217
];
b2=[48
43
42
40
37
44
35
41
36
34
43
38
33
];
c=[401
212
781
832
86
382
595
284
665
600
350
250
200
];
power_max=[20
76
100
197
12
155
400
50
350
250
100
65
50
];
power_min=[10
15.2
40
69
4
54.3
150
20
140
100
40
25
15
];
rn=[4
4
3
3
5
4
2
6
1
];

f=zeros(44,1);
f1=zeros(44,1);
    
% 0.8*(3405+250*x1+100*x2+65*x3+50*x4)>=2850*1.3;
% (3405+250*x1+100*x2+65*x3+50*x4-400)>=2850*1.3;
A=zeros(11,45);
A=[-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50
    -250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50,-250,-100,-65,-50
    1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0
    0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0
    0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0
    0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1
      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    ];

hour_biaoyao=[
    0.67 
0.63 
0.59 
0.58 
0.59 
0.60 
0.74 
0.86 
0.95 
0.96 
0.96 
0.95 
0.94 
0.95 
0.95 
0.96 
0.98 
1.00 
1.00 
0.95 
0.91 
0.82 
0.73 
0.63 
];

for i=1:44
x=zeros(44,1);
x(i)=1;
f1(i)=0.0888*(0.9259*(220*x(1)+90*x(2)+60*x(3)+50*x(4))+ 0.8573*(220*x(5)+90*x(6)+60*x(7)+50*x(8))+0.7938*(220*x(9)+90*x(10)+60*x(11)+50*x(12))+ 0.7350*(220*x(13)+90*x(14)+60*x(15)+50*x(16))+0.6806*(220*x(17)+90*x(18)+60*x(19)+50*x(20))+0.6302*(220*x(21)+90*x(22)+60*x(23)+50*x(24))+0.5835*(220*x(25)+90*x(26)+60*x(27)+50*x(28))+ 0.5403*(220*x(29)+90*x(30)+60*x(31)+50*x(32))+0.5002*(220*x(33)+90*x(34)+60*x(35)+50*x(36))+ 0.4632*(220*x(37)+90*x(38)+60*x(39)+50*x(40))+0.4289*(220*x(41)+90*x(42)+60*x(43)+50*x(44)));
end


b=[-1226.25;-700;3;6;10;10;0];
lb=zeros(44,1);
ub=zeros(44,1);

for i=0:10
ub(i*4+1) =1;
ub(i*4+2) =2;
ub(i*4+3) =3;
ub(i*4+4) =2;
end
for i=0:10
ub2(i*4+1) =0;
ub2(i*4+2) =0;
ub2(i*4+3) =0;
ub2(i*4+4) =1;
end
ic_12=1:44;
% [x,fval,exitflag,output,lambda]=linprog(f,A,b,[],[],lb,ub)
hoursum=zeros(24,46);

% [x_12,fval_12,flag_12]=intlinprog(f,ic_12,A,b,[],[],lb,ub);

for hour=1:24
 man_num=1;
for rem_x=30:0.001:50
PG=zeros(14,1);
    PG_sum=0;
for i=1:13
    PG(i)=(rem_x-b2(i))/(2*a(i));
    if  PG(i)<power_min(i)
        PG(i)=power_min(i);
    end
    if  PG(i)>power_max(i)
        PG(i)=power_max(i);
    end
end
for i=1:9
     PG_sum=PG(i)*rn(i)+PG_sum; 
end
    b(7)=PG_sum-((2850*1.3)*hour_biaoyao(hour));
    for k=1:11
    A(7,(k-1)*4+1)=-PG(10);
    A(7,(k-1)*4+2)=-PG(11);
    A(7,(k-1)*4+3)=-PG(12);
    A(7,(k-1)*4+4)=-PG(13);
    end
 for ZEG=1:44   
SUMG=zeros(12,1);
x=zeros(44,1);
x(ZEG)=1;

for j=1:9
    SUMG(1)=rn(j)*(a(j)*PG(j)*PG(j)+b2(j)*PG(j)+c(j));
end
SUMG(1)=SUMG(1)*11;
for i=1:11
SUMG(i+1)=(12-i)*(x((i-1)*4+1)*(a(10)*PG(10)*PG(10)+b2(10)*PG(10)+c(10))+x((i-1)*4+2)*(a(11)*PG(11)*PG(11)+b2(11)*PG(11)+c(11))+x((i-1)*4+3)*(a(12)*PG(12)*PG(12)+b2(12)*PG(12)+c(12))+x((i-1)*4+4)*(a(13)*PG(13)*PG(13)+b2(13)*PG(13)+c(13)));
end

SUMG_G=sum(SUMG(2:12));
f(ZEG)=SUMG_G;
 end
 flag_12=0;
 [x_12,fval_12,flag_12]=intlinprog(f,ic_12,A,b,[],[],lb,ub);

if flag_12==1 
    SUM(1,man_num)=(1.332*(fval_12+SUMG(1)))+0.0888*(0.9259*(220*x_12(1)+90*x_12(2)+60*x_12(3)+50*x_12(4))+ 0.8573*(220*x_12(5)+90*x_12(6)+60*x_12(7)+50*x_12(8))+0.7938*(220*x_12(9)+90*x_12(10)+60*x_12(11)+50*x_12(12))+ 0.7350*(220*x_12(13)+90*x_12(14)+60*x_12(15)+50*x_12(16))+0.6806*(220*x_12(17)+90*x_12(18)+60*x_12(19)+50*x_12(20))+0.6302*(220*x_12(21)+90*x_12(22)+60*x_12(23)+50*x_12(24))+0.5835*(220*x_12(25)+90*x_12(26)+60*x_12(27)+50*x_12(28))+ 0.5403*(220*x_12(29)+90*x_12(30)+60*x_12(31)+50*x_12(32))+0.5002*(220*x_12(33)+90*x_12(34)+60*x_12(35)+50*x_12(36))+ 0.4632*(220*x_12(37)+90*x_12(38)+60*x_12(39)+50*x_12(40))+0.4289*(220*x_12(41)+90*x_12(42)+60*x_12(43)+50*x_12(44)));
    SUM(2,man_num)=rem_x;
    man_num=man_num+1;
    
end
end
    [min_of_x  x180]=min(SUM(1,:));
    hoursum(hour,2)=SUM(2,x180(1));
    hoursum(hour,1)=SUM(1,x180(1));

    
   
 rem_x=hoursum(hour,2);
 
 PG=zeros(14,1);
    PG_sum=0;
for i=1:13
    PG(i)=(rem_x-b2(i))/(2*a(i));
    if  PG(i)<power_min(i)
        PG(i)=power_min(i);
    end
    if  PG(i)>power_max(i)
        PG(i)=power_max(i);
    end
end
for i=1:9
     PG_sum=PG(i)*rn(i)+PG_sum; 
end
    b(7)=PG_sum-((2850*1.3)*hour_biaoyao(hour));
    for k=1:11
    A(7,(k-1)*4+1)=-PG(10);
    A(7,(k-1)*4+2)=-PG(11);
    A(7,(k-1)*4+3)=-PG(12);
    A(7,(k-1)*4+4)=-PG(13);
    end

 for ZEG=1:44   
SUMG=zeros(12,1);
x=zeros(44,1);
x(ZEG)=1;

for j=1:9
    SUMG(1)=rn(j)*(a(j)*PG(j)*PG(j)+b2(j)*PG(j)+c(j));
end
SUMG(1)=SUMG(1)*11;
for i=1:11
SUMG(i+1)=(12-i)*(x((i-1)*4+1)*(a(10)*PG(10)*PG(10)+b2(10)*PG(10)+c(10))+x((i-1)*4+2)*(a(11)*PG(11)*PG(11)+b2(11)*PG(11)+c(11))+x((i-1)*4+3)*(a(12)*PG(12)*PG(12)+b2(12)*PG(12)+c(12))+x((i-1)*4+4)*(a(13)*PG(13)*PG(13)+b2(13)*PG(13)+c(13)));
end

SUMG_G=sum(SUMG(2:12));
f(ZEG)=SUMG_G;
 end

 [x_12,fval_12,flag_12]=intlinprog(f,ic_12,A,b,[],[],lb,ub);

   hoursum(hour,3:46) =x_12(1:44);
    
end













 
 
