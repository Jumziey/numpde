variables %Initiate common variables

time = 20; %In sec
timeStop = 1.2;

dt = dx/c;%dx/c %Just first try
dt = dt*0.1;
func = 3;

%Update scheme - Explicit (assuming that endpoints are fixed at zero
%													 Only want to update (2:end-1) )
%First iteration is a special case
v = (c*dt/dx)^2
u1 = @(u) v/2 *([u(2:end);0] - 2*u + [0;u(1:end-1)]) + u;
%Update from second iteration and onwards
u = @(u, uo) v/2*([u(2:end); u(1)] - 2*u + [u(end);u(1:end-1)]) + 2*u - uo; 

%Initial Valuesep.
grid = f{func}(xAxis);

%Control Plot
ph = plot(xAxis,grid);
title('Initial Conditions')
pause
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])

%First loop - Special conditions
grid = u1(grid);
oldGrid = grid;

%Control Plot
set(ph,'YData',grid)
title('First Iteration')
pause


stop = true;
for i = 0:time/dt
	ngrid = u(grid,oldGrid);
	ngrid(1) = 0; ngrid(end) = 0;
	oldGrid = grid;
	grid = ngrid;
	%pause
	set(ph,'YData', grid)
	title(sprintf('Explicit	... %.3f s. of %d s.',i*dt,time))
	drawnow;
	if i*dt >timeStop && stop==true
		stop = false;
		pause
	end
end


