clc
clear all

%%% Solve Wave equation Utt = c^2Uxx %%%

L = 10; % meters
c = 10; % m/s
NG = 128; % Number of grid points
dx = L/(NG-1); % Mesh size
dt = 0.003194219858756; % Time step = sqrt(nu*dx^2/(c^2))
nu = c^2*dt^2/(dx^2)/5;
x = 0:dx:L; % Grid
N = length(x);

%%% Initial Conditions %%%
% a)
ICa = exp(-(x-L/2).^2);
% b)
ICb = sin(0.2*pi*x);
% c)
ICc = 0*(x<=10/3) + 1*(x>10/3).*(x<20/3) + 0*(x>=20/3);

%% 1) Explicit Method
u = ICa; % Set IC
uold = u;
tN = 500;

% subplot(2,3,1)
plot(x,u)
axis([0 L -1 1])
title('Explicit Method')

for k=2:tN
    up = [u(2:end) u(1)];
    um = [u(end) u(1:end-1)];
    unew = 2*u-uold + nu*(up+um-2*u);
    unew(1) = 0; unew(end) = 0;
    uold = u;
    u = unew;
    
    plot(x,u)
    axis([0 L -1 1])
    title('Explicit Method')
    pause(0.01)
end

%% 2) Implicit Method
u = ICa; % Set IC
uold = u;
tN = 500;

%%% Creating Matrices %%%
Asub = [-nu*ones(1,N-2) 0];
Amid = [1 (1+2*nu)*ones(1,N-2) 1];
Asup = [0 -nu*ones(1,N-2)];
A = gallery('tridiag', Asub, Amid, Asup);

B = 2*eye(N);
C = -1*eye(N);

% subplot(2,3,2)
plot(x,u)
axis([0 L -1 1])
title('Implicit Method')
for k=2:tN
    unew = A\(B*u'+C*uold');
    uold = u;
    u = unew';
    
    plot(x,u)
    axis([0 L -1 1])
    title('Implicit Method')
    pause(0.01)
end

%% 3) Crank-Nicholson
u = ICa; % Set IC
uold = u;
tN = 500;

%%% Creating Matrices %%%
Asub = [-nu/2*ones(1,N-2) 0];
Amid = [1 (1+nu)*ones(1,N-2) 1];
Asup = [0 -nu/2*ones(1,N-2)];
A = gallery('tridiag', Asub, Amid, Asup);

B = 2*eye(N);

Csub = [nu/2*ones(1,N-2) 0];
Cmid = -(1+nu)*ones(1,N);
Csup = [0 nu/2*ones(1,N-2)];
C = gallery('tridiag', Csub, Cmid, Csup);

% subplot(2,3,3)
plot(x,u)
axis([0 L -1 1])
title('Crank-Nicholson Method')
for k=2:tN
    unew = A\(B*u'+C*uold');
    unew(1)=0; unew(end)=0;
    uold = u;
    u = unew';
    
    plot(x,u)
    axis([0 L -1 1])
    title('Crank-Nicholson Method')
    pause(0.01)
end

%% FFT With Time Stepping In Normal Space
u = ICa; % Set IC
uold = u;
tN = 500;
dt = 0.01;
nu = c^2*dt^2;

% Create the k-vector
%k=(0,dk,2*dk,3*dk, ..., N/2*dk, -(N-1)/2*dk, -(N-2)/2*dk,
% ..., -3*dk , -2*dk, -1*dk)
dk = 1/L;
k(1)=0;
k(N/2+1)=N/2*dk;
for j=2:N/2
    k(j)=(j-1)*dk;
    k(N+2-j)=-k(j);
end

% subplot(2,3,4)
plot(x,u)
axis([0 L -1 1])
title('FFT With Time Stepping in x')

for t=2:tN
    % Make an FFT of u(x,0)
    F = fft(u,N);

    % Multiply F(u) by -k^2 for all values
    F = -k.^2.*F;

    % Make an inverse transform g(x)
    g = ifft(F,N);
    
    % Solve unew = 2*u-uold + nu*g(x)
    unew = 2*u-uold + nu*g;
    unew(1) = 0; unew(end) = 0;
    uold = u;
    u = unew;
    plot(x,u)
    axis([0 L -1 1])
    title('FFT With Time Stepping in x')
    pause(0.01)
end

%% FFT With Time Stepping In k-Space
u = ICb; % Set IC
Fu = fft(u,N);
Fuold = Fu;
tN = 500;
dt = 0.01;
nu = c^2*dt^2;

% Create the k-vector
%k=(0,dk,2*dk,3*dk, ..., N/2*dk, -(N-1)/2*dk, -(N-2)/2*dk,
% ..., -3*dk , -2*dk, -1*dk)
dk = 1/L;
k(1)=0;
k(N/2+1)=N/2*dk;
for j=2:N/2
    k(j)=(j-1)*dk;
    k(N+2-j)=-k(j);
end

% subplot(2,3,5)
plot(x,u)
axis([0 L -1 1])
title('FFT With Time Stepping in k-space')

for t=2:tN    
    % Solve unew = 2*u-uold + nu*g(x)
    Funew = 2*Fu-Fuold - nu*k.^2.*Fu;
    
    u = ifft(Funew,N)
    u(1) = 0; u(end) = 0;
    Funew = fft(u,N);
    
    Fuold = Fu;
    Fu = Funew;
    
    plot(x,u)
    axis([0 L -1 1])
    title('FFT With Time Stepping in k-space')
    pause(0.01)
end
    
%% FFT Without Time Stepping
NG = 128; % Number of grid points
dx = L/(NG); % Mesh size
x = 0:dx:L-dx;
ICa = exp(-(x-L/2).^2);
ICb = sin(0.2*pi*x);
ICc = 0*(x<=10/3) + 1*(x>10/3).*(x<20/3) + 0*(x>=20/3);
u = [ICa 0 -ICa(end:-1:2)]; % Set IC

uold = u;
tN = 50;
time = linspace(0,10,tN);
dt = 0.01;
nu = c^2*dt^2;
AB = 1/2*fft(u,2*N);

% Create the k-vector
%k=(0,dk,2*dk,3*dk, ..., N/2*dk, -(N-1)/2*dk, -(N-2)/2*dk,
% ..., -3*dk , -2*dk, -1*dk)
dk = 1/L;
k(1)=0;
k(2*N/2+1)=2*N/2*dk;
for j=2:2*N/2
    k(j)=(j-1)*dk;
    k(2*N+2-j)=-k(j);
end

% subplot(2,3,6)
for t=2:tN
    FFu = AB.*exp(1i.*c.*k.*time(t)) + AB.*exp(-1i.*c.*k.*time(t));
    u = ifft(FFu,2*N);
    
    plot(x,u(1:N))
    axis([0 L -1 1])
    title('FFT Without Time Stepping')
    pause(0.1)
end

% % Wrong implementation
% u = [ICb -ICb(end:-1:1)]; % Set IC
% plot(u,'b-')
% hold on
% u = [ICb 0 -ICb(end:-1:2)]; % Set IC
% plot(u,'r-')