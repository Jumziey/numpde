clear all; close all;
L = 10.0;
c = 10.0;

gp = 512;
xAxis = linspace(0,L,gp)';
dx = L/gp;

Fn = @(x) exp(-(x-L/2).^2);
Fs = @(x) sin((pi/5)*x);
Fp = @(x) 0*(x<10/3) + (10/3<x).*(x<20/3) + 0*(x>20/3);
f = {Fn, Fs, Fp};
