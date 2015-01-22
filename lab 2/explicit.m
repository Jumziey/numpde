clear all; close all;
L = 10.0;
c = 10.0;
gp = 512;
time = 1; %In sec
timeStop = 0.5;
func = 1;

grid = linspace(0,L,gp)'; %Values used for initialization
xAxis = linspace(0,L,gp)';
dx = L/gp;
dt = dx/c %Just first try
dt = dt/1.4;

Fn = @(x) exp(-(x-L/2).^2);
Fs = @(x) sin((pi/5)*x);
Fp = @(x) 10/3<x && x<20/3;


%Update scheme - Explicit (assuming that endpoints are fixed at zero
%													 Only want to update (2:end-1) )
%First iteration is a special case
u1 = @(u) c^2/2 * (dt/dx)^2 *([u(2:end);0] - 2*u + [0;u(1:end-1)]) + u;
%Update from second iteration and onwards
u = @(u, uo) c^2 * (dt/dx)^2 * ([u(2:end);0] - 2*u + [0;u(1:end-1)]) + 2*u - uo; 

%Initial Values
grid(1) = 0;
grid(end) = 0;
grid(2:end-1) = Fn(grid(2:end-1));

%Control Plot
ph = plot(xAxis,grid)
title('Initial Conditions')
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])
pause
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])

%First loop - Special conditions
grid(2:end-1) = u1(grid(2:end-1));
oldGrid = grid;

%Control Plot
set(ph,'YData',grid)
title('First Iteration')
pause


stop = true;
for i = 0:time/dt
	grid(2:end-1) = u(grid(2:end-1),oldGrid(2:end-1));
	oldGrid = grid;
	%pause
	set(ph,'YData', grid)
	title(sprintf('Iterative method ongoing... %.3f s. of %d s.',i*dt,time))
	drawnow;
	if i*dt >timeStop && stop==true
		stop = false;
		pause
	end
end


