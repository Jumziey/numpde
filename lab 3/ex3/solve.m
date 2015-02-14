N = 256;
h = 1/N;
x = 0:h:1;
g0 = 0;
gl = 7;
g = [g0 gl];
f = @(x) 0;
kappa = [10^6 10^6]; %Dirchlet

S = stiffnessAssembler1D(x, kappa);
b = sourceAssembler1D(x,f, kappa, g);

xi = S\b;
plot(x,xi)

title('System Solved Using FEM for inohomogeneous BC')
