function [h,g]=myfun2(x)
h=-x(1)^2+x(2);
g=-x(1)-x(2)^2+2;
end