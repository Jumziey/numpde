clear all; close all;
geom = [2 0 1 0 0 1 0;
		2 1 1 0 1 1 0;
		2 1 0 1 1 1 0;
		2 0 0 1 0 1 0]';
		
i = 1;
i = 1;
stepSerie = [0.2 0.1 0.05 0.025];
for hmax = stepSerie
	[p,e,t] = initmesh(geom, 'Hmax', hmax);
	subplot(2,2,i)
	pdemesh(p,e,t)
	i=i+1;
	title(sprintf('h_{max} = %.3f',hmax))
end 
%}

figure(2)
f = @(x,y) 2*pi^2*sin(pi*x)*sin(pi*y)+sin(pi*y)*sin(pi*x);
i = 1;
for hmax = stepSerie
	hmax
	[p,e,t] = initmesh(geom, 'Hmax', hmax);
	[A,M,R] = systemMatrixAssembler(p,e,t);
	S = A+M+R;
	l = loadAssembler(p,e,t,f);

	xi = S\l;
	
	subplot(2,2,i)
	pdesurf(p,t,xi)
	Enorm(i) = sqrt(abs(pi^2/2 + 1/4-abs(xi'*(A+M)*xi)));
	title(sprintf('h_{max} = %.3f',hmax))
	i = i+1;
end

figure(3)

p = polyfit(stepSerie,Enorm,1);
fit = @(x) p(1).*x + p(2);
loglog(stepSerie,Enorm, 'b')
hold on
loglog(stepSerie,fit(stepSerie), 'g')
legend('Measured Data', 'Linear Fit')
p = polyfit(log(stepSerie),log(Enorm), 1)
cs = log(stepSerie(1)/stepSerie(2))/log(Enorm(1)/Enorm(2))
title(sprintf('||u-u_h||_E, fitted s = %.4f ,calculated s = %.4f', p(1),cs))
