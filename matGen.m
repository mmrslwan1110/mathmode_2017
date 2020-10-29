function [ matrix ] = matGen(n)
a = linspace(1,(2^n-1),2^n-1);
b = dec2bin(a);
for i = 1:2^n-1
if i==1
matrix = b(1,1:n);
else
matrix= [matrix;b(i,1:n)];
 end
end
end