
clear all 
close all

%Periodic Condition
NG = 40;
L = 400;
Vm = 25;
Pm = 1;
dx = L/NG;
dt = (dx/Vm); %CLF on max velocity
t = [0 50];

p = zeros(NG,1);
p(NG/4:3*NG/4) = Pm;

lax = @(p,jm,j,jp) 1/2*(p(jp)+p(jm)) - dt/(2*dx)*( Vm*(p(jp)-p(jp)^2/Pm) - Vm*(p(jm)-p(jm)^2/Pm));

laxwen = @(p,jm,j,jp) p(j) - dt/(2*dx)*Vm*(1-p(jp)/Pm - (1-p(jm)/Pm)) + 2*(dt/(2*dx))^2 * Vm^2 * ((1-p(jp)/Pm - (1-p(j)/Pm)) - ((1-p(j)/Pm)-(1-p(jm)/Pm)))  

%LAX
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
        p(j) = laxwen(p,jm,j,jp);
    end
    %spo = pn;
    axis([0 400 0 1])
    plot(1:dx:L,p)
    axis([0 400 0 1])
		time
    pause(0.02)
end
