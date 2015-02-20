function [A, M] = systemMatrixAssembler(p,e,t)
%For the shroedinger problem we need
%the stiffnes matrix + mass matrix + explicit dirchlet on the boundary
%Btw, implementation is not made for efficiency, only clarity. Putting everything in the same
%for loop would be much better from an efficiency standpoint. 
	np = size(p,2);
	A = sparse(np,np);
	M = sparse(np,np);

	for k = 1:size(t,2)
		%Stiffness Matrix
		triNodes = t(1:3,k);%Nodes containing the current triangle
		[area,b,c] = HatGradients(p(1,triNodes),p(2,triNodes));
		Ak = (b*b'+c*c')*area; % a = 1 for this lab
		A(triNodes,triNodes) = A(triNodes, triNodes) + Ak;
		
		%Mass matrix
		Mk = [2 1 1;
			  1 2 1;
			  1 1 2;]*area/12;
		M(triNodes,triNodes) = M(triNodes,triNodes) + Mk;
	end
end


%x and y holds the node coordinates of the triangle we're currently 
%working on.
function [area,b,c] = HatGradients(x,y)
	area=polyarea(x,y);
	b=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
	c=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
end
