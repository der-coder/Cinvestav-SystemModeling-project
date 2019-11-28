function Pen_H
%% Simulacion del pendulo
clear
clc
close all
%% Variables para ODE45
tspan = [0 15];
theta = pi/2;
p0 = [0 theta ];         %theta, d_theta

[t,x] = ode45(@pendulo,tspan,p0);

figure('Name','Poscicion y Momento')
plot(t,x(:,2),'k',t,x(:,1),'k--','linewidth',3)
xlabel('Tiempo','fontsize',16)
ylabel('\theta,P\theta','fontsize',16)
legend('\theta','P\theta')
title('Posicion/Momento p�ndulo','fontsize',18)
set(gcf,'Color',[1 1 1])
grid on

figure('Name','Retrato Fase')
plot(x(:,2),x(:,1),'k','linewidth',3)
xlabel('Posicion (\theta)','fontsize',14)
ylabel('Momento (P\theta)','fontsize',14)
title('Retrato fase \theta/P\theta','fontsize',16)
set(gcf,'Color',[1 1 1])
grid on
end

%% Funcion para ODE45
function dx = pendulo(~,x)
%Parametros del pendulo
dx=zeros(2,1);
g = 9.81;       % Gravedad (m/s^2)
l = 0.193;        % Largo del pendulo (m)
m = 0.1232109;    % Masa de la bola (kg)
dx(1) = -m*g*l*sin(x(2));
dx(2) = x(1)/(m*l^2);
end
