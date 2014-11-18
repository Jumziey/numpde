
clear all 
close all

%Periodic Condition
NG = 40;
L = 400;
Vm = 25;
Pm = 1;
dx = L/NG;
dt = (dx/Vm); %CLF on max velocity
t = [0 400];

po = zeros(NG,1);
po(NG/4:3*NG/4) = Pm;


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
        pn(j) = 1/2*(po(jp)+po(jm)) - dt/(2*dx)*( Vm*(po(jp)-po(jp)^2/Pm) - Vm*(po(jm)-po(jm)^2/Pm));
    end
    po = pn;
    axis([0 400 0 1])
    plot(1:dx:L,po)
    axis([0 400 0 1])
    pause(0.02)
end
