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

for time = t(1):dt:t(2)
	for j = 1:NG
		switch j
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
