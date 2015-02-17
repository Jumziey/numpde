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
