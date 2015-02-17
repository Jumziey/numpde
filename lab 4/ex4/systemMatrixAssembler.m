function S = systemMatrixAssembler(p,e,t)
%For the poisson problem we only need
%the stiffnes matrix + some terms on the boundary
	np = size(p,2);
	A = sparse(np,np);
	R = sparse(np,np);
	for k = 1:size(t,2)
		triNodes = t(1:3,k);%Nodes containing the current triangle
		[area,b,c] = HatGradients(p(1,triNodes),p(2,triNodes));
		Ak = (b*b'+c*c')*area; % a = 1 for this lab
		A(triNodes,triNodes) = A(triNodes, triNodes) + Ak;
	end
	
	%We have to add the boundary conditions too u=0 (not a natural BC!)
	for E = 1:size(e,2)
		eNodes = e(1:2,E);
		x = p(1, eNodes);
		y = p(2, eNodes);
		len = sqrt((x(1)-x(2))^2+(y(1)-y(2))^2);
		RE = 10^6*[1 1; 1 1];  %We just set the node values to very high to simulate u=0 at boundary
		R(eNodes,eNodes) = R(eNodes,eNodes) +RE;
	end
	S = A+R; %Lets build the system matrix
end


%x and y holds the node coordinates of the triangle we're currently 
%working on.
function [area,b,c] = HatGradients(x,y)
	area=polyarea(x,y);
	b=[y(2)-y(3); y(3)-y(1); y(1)-y(2)]/2/area;
	c=[x(3)-x(2); x(1)-x(3); x(2)-x(1)]/2/area;
end
