function b = LoadAssembler1D(x,f)
	n = length(x)-1; 
	b = zeros(n+1,1);
	%Using trapezoidal rule
	for i = 1:n
		h = x(i+1) - x(i);
		b(i) = b(i) + f(x(i))*h/2;
		b(i+1) = f(x(i+1))*h/2 + b(i+1) %Do we need b(i+1)? i cant see why
	end
end
