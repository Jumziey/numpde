clear all; close all;
geom = [2 0 1 0 0 1 0;
		2 1 1 0 1 1 0;
		2 1 0 1 1 1 0;
		2 0 0 1 0 1 0]';
		

%{%Mesh plot
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
f = @(x,y) 2*pi^2*sin(pi*x)*sin(pi*y);
i = 1;
for hmax = stepSerie
	[p,e,t] = initmesh(geom, 'Hmax', hmax);
	S = systemMatrixAssembler(p,e,t);
	l = loadAssembler(p,e,t,f);

	xi = S\l;
	
	subplot(2,2,i)
	pdesurf(p,t,xi)
	Enorm(i) =  sqrt(abs(pi^2/2-xi'*S*xi));
	title(sprintf('h_{max} = %.3f',hmax))
	i = i+1;
end

figure(3) %Energy Error norms

pf = polyfit(stepSerie,Enorm,1);
fit = @(x) pf(1).*x + pf(2);
loglog(stepSerie,Enorm, 'b')
hold on
loglog(stepSerie,fit(stepSerie), 'g')
legend('Measured Data', 'Linear Fit')
pf = polyfit(log(stepSerie),log(Enorm), 1)
cs = log(stepSerie(1)/stepSerie(2))/log(Enorm(1)/Enorm(2))
title(sprintf('||u-u_h||_E, fitted s = %.4f ,calculated s = %.4f', pf(1),cs))

figure(4) %Plot analytical
fanal = @(x,y) sin(pi*x).*sin(pi*y);
pdesurf(p,t,fanal(p(1,:),p(2,:))')
title('Analytical solution f = sin(\pi x)sin(\pi y)')
