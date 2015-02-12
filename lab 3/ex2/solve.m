clear all; close all; 

N= 16;
h = 1/N;
x = (0:h:1);
f = @(x) 2;
A = stiffAssembly(x);
b = loadAssembly(x,f);

psi = A\b;
plot(x,psi) %We do not plot with hat basis since it's basically one for every psi value. 
hold on

figure(2) %Now we need some value for the norm of error
%Energy norm value
%A(1,1) = 32;
%A(end,end) = 32;
Enorm = -1+4/3 - psi'*A*psi %WOOPA!
n1 = ones(size(psi));
L2norm = sum(psi.^2 .* (n1-n1./h).^2.*h)


%legend('16 intervals')
%title('Solving the System with -u'''' = 2')