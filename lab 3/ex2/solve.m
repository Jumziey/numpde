clear all; close all; 

for N = [2 4 16 256]
	h = 1/N;
	x = 0:h:1;
	f = @(x) 2;
	A = stiffAssembly(x);
	b = loadAssembly(x,f);

	Uh = A\b;
	plot(x,Uh)
	hold on
end

legend('2 intervals','4 intervals','16 intervals','256 intervals')
title('Solving the System with -u'''' = 2')