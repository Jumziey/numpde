variables %Initiate common variables

time = 100; %In sec
timeStop = 0.5;
func = 1;

dt = dx/c %Just first try
dt = dt/5;
q = c^2/(2*dx^2);

%Update scheme - implicit solution for wave equation
%Creating matrices for the system
A = zeros(gp);
A(1,1) = dx^2;
A(end,end) = dx^2;
for i = 2:gp-1
	j = i-1;
	A(i,j) = 1;
	A(i,j+1) = -(2+q/dt^2);
	A(i,j+2) = 1;
end
A = (1/q)*A;
% C matrix
C = zeros(gp);
C(1,1) = dx^2;
C(end,end) = dx^2;
for i = 2:gp-1
	j = i-1;
	C(i,j) = -1;
	C(i,j+1) = 2+1/(q*dt^2);
	C(i,j+2) = -1;
end
C = q*C;


%Update Functions
%First - Special Case
u1 = @(u) (A-C)\((-2/dt^2)*u);
%Update scheme for the all the rest
u = @(u,uo) A\(C*uo - (2/dt^2)*u);


%Initial Values

grid = f{func}(xAxis);
grid(1) = 0;
grid(end) = 0;

%Control Plot
ph = plot(xAxis,grid)
title('Initial Conditions')
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])
pause
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])


%First loop - Special conditions
grid = u1(grid);
grid(1,1) = 0;
grid(end,end) = 0;
oldGrid = grid;

%Control Plot
set(ph,'YData',grid)
title('First Iteration')
pause



stop = true;
for i = 0:time/dt
	ngrid = u(grid,oldGrid);
	ngrid(1,1) = 0;
	ngrid(end,end) = 0;
	oldGrid = grid;
	grid = ngrid;
	%pause
	set(ph,'YData', grid)
	title(sprintf('Crank-Nicholson... %.3f s. of %d s.',i*dt,time))
	drawnow;
	if i*dt >timeStop && stop==true
		stop = false;
		pause
	end
end


