function l = loadAssembler(p,e,t,f)
%load assembler for first poisson problem
	b = sparse(size(p,2),1);
	r = sparse(size(p,2),1);
	for k = 1:size(t,2) %Go through all triangles
		triNodes = t(1:3,k); %Boundary nodes, based on geom matrix
		x = p(1,triNodes);
		y = p(2,triNodes);
		area = polyarea(x,y);
		bk = [f(x(1),y(1)); 
			  f(x(2),y(2)); 
			  f(x(3),y(3))]/3*area;
		b(triNodes) = b(triNodes)+bk;
	end
	l = b;
