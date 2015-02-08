clear all; close all;

i=0;
for n = [2 5 10] 
	i = i+1;
	subplot(1,3,i)
	x = linspace(0,1,n+1)
	plot(x,hatfun(x,1:length(x),2))
	title(sprintf('n = %d', n));
end