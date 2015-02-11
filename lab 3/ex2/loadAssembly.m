function b = loadAssembly(x,f)
%Assembles a load vector for x with 
%f using trapezoidal integration
	n = length(x) - 1; %subintervals
	b = zeros(n+1, 1);
	for i = 1:n
		h = x(i+1)  - x(i);
		b(i) = b(i) + f(x(i))*h/2;
		b(i+1) = b(i+1) + f(x(i+1))*h/2;
	end
	
