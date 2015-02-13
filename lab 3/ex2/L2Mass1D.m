function M = L2Mass1D(x)
	n = length(x)-1; % number of subintervals
	M = zeros(n+1,n+1); % allocate mass matrix
	%Using simpsons
	for i = 1:n % loop over subintervals
		h = x(i+1) - x(i); % interval length
		%Basically adding on the 2x2 matrix we talked about in the lectures
		M(i,i) = M(i,i) + h/3; % add h/3 to M(i,i)
		M(i,i+1) = M(i,i+1) + h/6;  %subdiagonals
		M(i+1,i) = M(i+1,i) + h/6;
		M(i+1,i+1) = M(i+1,i+1) + h/3;
	end
