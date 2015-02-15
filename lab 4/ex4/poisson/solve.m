clear all; close all;
geom = [2 0 1 0 0 1 0;
		2 1 1 0 1 1 0;
		2 1 0 1 1 1 0;
		2 0 0 1 0 1 0]';
		
i = 1;

for hmax = [0.2] 
	[p,e,t] = initmesh(geom, 'Hmax', hmax);
	%subplot(2,2,i)
	%pdemesh(p,e,t)
	i=i+1;
	%title(sprintf('h_{max} = %.3f',hmax))
end 

f = @(x,y) 2*pi^2*sin(pi*x)*sin(pi*y);

S = systemMatrixAssembler(p,t);
l = loadAssembler(p,t,f);

u = S\l;

pdesurf(p,t,u)
