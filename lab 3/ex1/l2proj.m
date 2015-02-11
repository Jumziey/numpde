clear all; close all; 

f = @(x) x.*(1-x);

n = 5;
h = 1/n;
x = 0:h:1;
M = L2Mass1D(x);
b1 = L2Load1D(x,f);
b2 = LoadAssemblerS1D(x,f);
Pf1 = (M\b1)';
Pf2 = (M\b2)';
plot(x,Pf1);
hold on
plot(x,Pf2);

x2 = linspace(0,1,100);
plot(x2,f(x2), '.g');

legend('Trapezoidal', 'Simpsons', 'Correct values')
title('Estimate of x(1-x) using 5 points')
