function octave_compare
%% Simulacion del pendulo
clear
clc
close all
%% Load data obtained from Tracker
data = csvread('Pendulum.csv');
t = data(:,1);
omega = data(:,3);
theta = data(:,4);
alpha = data(:,5);
% Simulation conditions
%%l = 0.193;        % Length (m)
l  = 0.22;
m = 0.1232109;    % Mass (kg)
k = 0.135;        % Friction coefficient
%%k = 0.1;
theta0 = pi/2;    % theta_0
p0 = [theta0 0];         %theta, d_theta
tspan = [0:4.2/128:4.2]; % Match total steps with video frames
%% RK45 solver
[time,sol] = ode45(@(t,y)pendulo(t,y,l,m,k),tspan,p0, '-AbsTol','1e-200', -'RelTol', '1e-200');
%% Plots 
figure(1)
plot(time, sol(:,1),'*k', t, theta, 'k')
legend({'RK45','Tracker'}, 'location', 'eastoutside', 'orientation', 'vertical')
legend('boxoff')
xlabel('Tiempo','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
title('Posición angular del péndulo','Interpreter','latex')
set(gcf,'Color',[1 1 1])
print('-dpdflatex', '../Report/img/prestrackerThetaL.tex', '-S300,150');

figure(2)
plot(time, sol(:,2),'*k', t, omega, 'k')
legend({'RK45','Tracker'}, 'location', 'eastoutside', 'orientation', 'vertical')
legend('boxoff')
xlabel('Tiempo','Interpreter','latex')
ylabel('$\dot \theta$','Interpreter','latex')
title('Velocidad angular del péndulo','Interpreter','latex')
print('-dpdflatex', '../Report/img/prestrackerdThetaL.tex', '-S300,150');
end

%% Funcion para ODE45
function dx = pendulo(~,x,l,m,k)
%Parametros del pendulo
g = 9.81;       % Gravedad (m/s^2)
dx(1) = x(2);
dx(2) = -(g/l)*sin(x(1)) - (k/m)*x(2);
dx = dx';
end