clear all; close all;
L = 10.0;
c = 10.0;
gp = 512;
time = 100; %In sec
timeStop = 2;
func = 3;

grid = linspace(0,L,gp)'; %Values used for initialization
xAxis = linspace(0,L,gp)';
dx = L/gp;
dt = dx/c %Just first try
dt = dt*1;

Fn = @(x) exp(-(x-L/2).^2);
Fs = @(x) sin((pi/5)*x);
Fp = @(x) 0*(x<10/3) + (10/3<x).*(x<20/3) + 0*(x>20/3);
f = {Fn, Fs, Fp};


%Update scheme - implicit solution for wave equation
%Creating a stiffness matrix for the problemj
A = zeros(gp)
A(1,1) = dx^2/c^2;
A(end,end) = dx^2/c^2;
for i = 2:gp-1
	j = i-1;
	A(i,j) = 1;
	A(i,j+1) = -(1+2*(dx/(c*dt))^2);
	A(i,j+2) = 1;
end
A = c^2/dx^2*A; 
%Update Functions
%First - Special Case
u1 = @(u) (A-(1/dt^2 * eye(gp)))\(-2/dt^2 * u);
%Update scheme for the all the rest
u = @(u,uo) A\((1/dt^2)*(-2*u+uo))


%Initial Values
grid(1) = 0;
grid(end) = 0;
grid(2:end-1) = f{func}(grid(2:end-1));

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
	title(sprintf('Implicit... %.3f s. of %d s.',i*dt,time))
	drawnow;
	if i*dt >timeStop && stop==true
		stop = false;
		pause
	end
end


