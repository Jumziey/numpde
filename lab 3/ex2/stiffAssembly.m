function A = stiffAssembly(x)
%Assembles a mass stiffness on x. (For this very specific problem) Actually its just the stiffness
	n = length(x) - 1; %subintervals
	A = zeros(n+1, n+1);
	for i = 1:n
		h = x(i+1) - x(i);
		n = [i i+1];
		A(n,n) = A(n,n) + [1 -1; -1 1]/h;
	end
	%BC
	A(1,1) = 10^6;
	A(end,end) = 10^6;