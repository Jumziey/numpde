
clear all 
close all

%Periodic Condition
NG = 40;
L = 400;
Vm = 25;
Pm = 1;
dx = L/NG;
dt = (dx/Vm); %CLF on max velocity
t = [0 10];

po = zeros(NG,1);
po(NG/4:3*NG/4) = Pm;
%po(3*NG/4) = Pm - 0.5; 

lax = @(p,jm,j,jp) 1/2*(p(jp)+p(jm)) - dt/(2*dx) *( p(jp)*Vm*(1-p(jp)/Pm) - p(jm)*Vm*(1-p(jm)/Pm));

v = @(p) Vm*(1-p/Pm);
F = @(p) p.*v(p);
q = @(p) Vm*(1 - 2*p/Pm);



laxwen = @(p,jm,j,jp) p(j) - ...
	dt/(2*dx)*(F(p(jp)) - F(p(jm))) + ...
	2*(dt/(2*dx))^2*( q((p(j)+p(jp))/2)*(F(p(jp))-F(p(j))) - q((p(j)+p(jm))/2)*(F(p(j))-F(p(jm))));

%Update loop
for time = t(1):dt:t(2)
    for j = 1:NG
        switch j %Periodic boundary condition
            case 1
                jm = NG;
                jp = j+1;
            case NG
                jm = j-1;
                jp = 1;
            otherwise
                jm = j-1;
                jp = j+1;
        end
        pn(j) = lax(po,jm,j,jp);
    end
    po = pn;
    %axis([0 400 .4 1.4])
    subplot(3,1,1)
    plot(1:dx:L,po)
    axis([0 400 0 1])
    ylabel('\rho')
    xlabel('Pos')
    subplot(3,1,2)
    plot(1:dx:L,v(po))
    axis([0 400 0 30])
    ylabel('v')
    xlabel('Pos')
    subplot(3,1,3)
    plot(1:dx:L,F(po))
    axis([0 400 0 10])
    ylabel('F')
    xlabel('Pos')
    pause(0.01)
end
