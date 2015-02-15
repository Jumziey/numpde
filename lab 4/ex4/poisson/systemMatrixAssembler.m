function S = systemMatrixAssembler(p,t)
%For the poisson problem we only need
%the stiffnes matrix + some terms on the boundary
	A = zeros(size(p,2),size(p,2));
	for k = 1:size(t,2)
		triNodes = t(1:3,k);%Nodes containing the current triangle
		[area,b,c] = HatGradients(p(1,triNodes),p(2,triNodes));
		Ak = (b*b'+c*c')*area; % a = 1 for this lab
		A(triNodes,triNodes) = A(triNodes, triNodes) + Ak;
	end
	S = A;
end

%x and y holds the node coordinates of the triangle we're currently 
%working on.
function [area,b,c] = HatGradients(x,y)
	area=polyarea(x,y);
	b=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
	c=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
end
