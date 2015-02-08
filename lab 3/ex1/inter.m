clear all; close all;

f = @(x) x.*(1-x);
i = 0;
for n = [2 5 10] 
	i = i+1;
	x = linspace(0,1,n+1);
	
	j = 0;
	for k = 1:length(x)
		j = j+1;
		fInter(j) = f(x(k)) %.*hatfun(x,k,k); %It becomes one every time!
	end
	plot(x,fInter)
	hold on
end

x = linspace(0,1,101);
plot(x,f(x));

legend('n = 2', 'n = 5', 'n = 10', 'n = 100')
title('Interpolation of x(1-x)');