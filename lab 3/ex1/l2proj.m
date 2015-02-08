clear all; close all; 

f = @(x) = x*(1-x);

n = 10;
h = 1/n;
x = 0:h:n;
M = L2Mass1D(x);
b = L2Load1D(x, @f);
Pf = M\b;
plot(x,Pf);
