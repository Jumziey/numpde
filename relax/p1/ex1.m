clear all;
close all;

h = 0.1;
xs = 1;
ys = 1;
x = -xs:h:xs;
y = -ys:h:ys;
gSize = [size(x,2), size(y,2)];
xMid = ceil(gSize(1)/2);
yMid = ceil(gSize(1)/2);
Xplot = 0.1:0.1:1;

%Initiate matrices
pot = ones(gSize(1), gSize(2))*0.1;
%Boundary cond
pot(end,:) = zeros(1,gSize(1));
pot(1,:) = zeros(1,gSize(1));
pot(:,end) =  zeros(gSize(2),1);
pot(:,1) = zeros(gSize(2),1);
pot(xMid,yMid) = -1;



table(:,1) = 0.1:0.1:1;
for i = 1:100
    pot = relaxStep(pot);
end


table(:,2) = pot(xMid+1:end,yMid);

for i = 100:1000
    opot = pot;
    pot = relaxStep(pot);
    
end
table(:,3) = pot(xMid+1:end,yMid);

pot1 = relaxStep(pot);
format long
table
max(max(abs(pot-pot1)))
format short

surf(x,y,pot)
xlabel('X pos');
ylabel('Y pos');
title('Laplace in 2D')

[Ey, Ex] = gradient(pot);
Ey = -Ey;
Ex = -Ex;

Xplot = 0.1:0.1:1;
figure(2);
subplot(2,1,1);
plot(Ex(xMid+1:end,yMid),Xplot)  
xlabel('E_x');
ylabel('X pos');
title('Simple plot');
subplot(2,1,2);
loglog(Ex(xMid+1:end,yMid),Xplot) 
xlabel('E_x');
ylabel('X pos');
title('Log Log plot');

figure(3);
subplot(2,1,1);
plot(1./Xplot,Xplot)  
xlabel('1/X');
ylabel('X value');
title('Simple plot');
subplot(2,1,2);
loglog(1./Xplot,Xplot) 
xlabel('1/X');
ylabel('X value');
title('Log Log plot');

%%%Change of middle material
pot = ones(gSize(1), gSize(2))*0.1;
%Boundary cond
pot(end,:) = zeros(1,gSize(1));
pot(1,:) = zeros(1,gSize(1));
pot(:,end) =  zeros(gSize(2),1);
pot(:,1) = zeros(gSize(2),1);

for i = 1:1000
    pot = relaxStep2(pot);
end

figure(4)
surf(x,y,pot)
xlabel('X pos');
ylabel('Y pos');
title('Laplace in 2D')


