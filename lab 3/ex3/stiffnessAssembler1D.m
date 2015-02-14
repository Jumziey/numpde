function A = StiffnessAssembler1D(x,kappa)
n = length(x)-1;
A = zeros(n+1,n+1);
for i = 1:n
	h = x(i+1) - x(i);
	xmid = (x(i+1) + x(i))/2; % interval mid-point
	A(i,i) = A(i,i) + 1/h;
	A(i,i+1) = A(i,i+1) - 1/h;
	A(i+1,i) = A(i+1,i) - 1/h;
	A(i+1,i+1) = A(i+1,i+1) + 1/h;
end
A(1,1) = A(1,1) + kappa(1);
A(n+1,n+1) = A(n+1,n+1) + kappa(2);
