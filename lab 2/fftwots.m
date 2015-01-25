variables %Initiate common variables

time = 100; %In sec
timeStop = 0.5;
func = 1;

dt = dx/c; %Just first try
dt = dt/5;
q = c^2/(2*dx^2);

%Init
%Create K-vector FOR WHICH I HAVE NO IDEA WHY IT SHOULD LOOK LIKE THIS!
dk = 1/L;
k(1)=0;
k(gp/2+1)=gp/2*dk;
for j=2:gp
    k(j)=(j-1)*dk;
    k(2*gp+2-j)=-k(j);
end
k = k';

%Initial condition
IC = f{1}(xAxis);
grid = [IC; 0; -IC(end:-1:2)];
C = (1/2) * fft(grid,2*gp);

%Control Plot
ph = plot(xAxis,grid(1:gp));
title('Initial Conditions')
axis([min(xAxis) max(xAxis) -max(grid) max(grid)])
pause

stop = true;
for t = 0:dt:time
	FT = C .* (exp(i*c*t*k) + exp(-i*c*t*k));
	size(FT);
	grid = ifft(FT, 2*gp);
	set(ph,'YData', grid(1:gp))
	title(sprintf('FFT w/o Time Stepping... %.3f s. of %d s.',t,time))
	drawnow;
	if i*dt >timeStop && stop==true
		stop = false;
		pause
	end
end


