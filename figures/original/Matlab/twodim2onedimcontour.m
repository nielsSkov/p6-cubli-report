clear all
close all
clc

% Symbolic function, gradient and Hessian manipulations
syms x1 x2;

f = -(cos(x1)^2 + cos(x2^2)^2)^2;

g = [ diff(f,x1)
      diff(f,x2) ];
    
H = [ diff(diff(f,x1),x1)
      diff(diff(f,x2),x2) ];


xx = solve(real(f),x1);
yy = solve(real(f),x2);


% Initial point
xinit1 = 0.4;
xinit2 = 0.85;
finit = -(cos(xinit1).^2 + cos(xinit2.^2).^2).^2 + 5;

% Calculations of the gradient line coefficients
ginit1 = subs(real(g(1)),x1,xinit1)
ginit1 = double(subs(real(ginit1),x2,xinit2))
ginit2 = subs(real(g(2)),x1,xinit1)
ginit2 = double(subs(real(ginit2),x2,xinit2))

a = ginit2/ginit1
b = xinit2 - a * xinit1

%-- 3D Plotting --%
[X,Y] = meshgrid(-1.5:.1:1.5);
f1 = -(cos(X).^2 + cos(Y.^2).^2).^2 + 5;

% 3D meshgrid
mesh(X,Y,f1);
title('Visualization of Gradient Direction of Arbitrary Function at a Starting Point');
xlabel('X1');
ylabel('X2');
zlabel('f(x)    ', 'Rotation', 0);
hold on;

% Gradient line and 1D cost function
xline = -0.6 : 0.01 : 1
yline = a * xline + b;
fline = -(cos(xline).^2 + cos(yline.^2).^2).^2 + 5;
plot3(xline,yline,fline,'r', 'LineWidth', 1.5)
plot3(xline,yline,zeros(size(xline)),'LineWidth', 1.5)

% Initial point
plot3(xinit1, xinit2, finit, 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 5)

legend('2D Cost function', '1D Cost function', 'Gradient direction projection', 'Starting point', 'Location','SouthEast')

% View parameters
axis([ -0.2 1.25 -0.8 1.5 0 6])

%--2D cost function--%
figure
plot(xline,fline, 'r', 'LineWidth', 1.5)
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
axis([ -0.6 0.5 0 6])
