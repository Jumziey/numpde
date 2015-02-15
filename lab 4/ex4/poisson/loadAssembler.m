function l = loadAssembler(p,t,f)
%load assembler for first poisson problem
b = zeros(size(p,2),1);
for k = 1:size(t,2) %The load vector is for all nodes!
	triNodes = t(1:3,k); %Boundary nodes, based on geom matrix
	x = p(1,triNodes); 
	y = p(2,triNodes); 
	area = polyarea(x,y);
	bk = [f(x(1),y(1)); f(x(2),y(2)); f(x(3),y(3))]*area/3;
	b(triNodes) = b(triNodes)+bk;
end
l = b;
