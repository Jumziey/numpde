function [A, M] = systemMatrices(p,e,t)
%For the shroedinger problem we need
%the stiffnes matrix + mass matrix + explicit dirchlet on the boundary
%Btw, implementation is not made for efficiency, only clarity. Putting everything in the same
%for loop would be much better from an efficiency standpoint. 
	np = size(p,2);
	A = sparse(np,np);
	M = sparse(np,np);
	%R = sparse(np,np);
	%Stiffness matrix
	for k = 1:size(t,2)
		triNodes = t(1:3,k);%Nodes containing the current triangle
		[area,b,c] = HatGradients(p(1,triNodes),p(2,triNodes));
		Mk = [2 1 1;
			  1 2 1;
			  1 1 2;]*area/12;
		Ak = (b*b'+c*c')*area; % a = 1 for this lab
		
		M(triNodes,triNodes) = M(triNodes,triNodes) + Mk;
		A(triNodes,triNodes) = A(triNodes, triNodes) + Ak;
	end
	%{
	%We have to add the boundary conditions too u=0 (not a natural BC!)
	for E = 1:size(e,2)
		eNodes = e(1:2,E);
		x = p(1, eNodes);
		y = p(2, eNodes);
		len = sqrt((x(1)-x(2))^2+(y(1)-y(2))^2);
		RE = 10^6*[2 1; 1 2];  %We just set the node values to very high to simulate u=0 at boundary
		R(eNodes,eNodes) = R(eNodes,eNodes) +RE;
	end
	%}
	
end


%x and y holds the node coordinates of the triangle we're currently 
%working on.
function [area,b,c] = HatGradients(x,y)
	area=polyarea(x,y);
	b=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
	c=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
end
