function octave_pendulum
%% Simulacion del pendulo
clear
clc
close all

%% Variables para ODE45

l = 0.193;        % Largo del pendulo (m)
m = 0.1232109;    % Masa de la bola (kg)
k = 0.1;        % Coeficiente de friccion 0.1
theta = pi/2;

p0 = [theta 0];         %theta, d_theta
tspan = [0 15];

[t,thet] = ode45(@(t,y)pendulo(t,y,l,m,k),tspan,p0, '-MaxStep','1e-50');

figure(1)
plot(t,thet(:,1),'k','linewidth',1,t,thet(:,2),'k--','linewidth',1)
xlim([0 15])
ylim([-12 12])
xlabel('Tiempo','Interpreter','latex')
ylabel('$\theta, \dot{\theta}$','Interpreter','latex')
legend({'  $\theta$','  $\dot{\theta}$'},'Interpreter','latex','location', 'northeast', 'orientation', 'horizontal')
legend('boxoff')
title('Posición y Velocidad del péndulo','Interpreter','latex')
set(gcf,'Color',[1 1 1])
##grid on

##print('-dpdflatex', '../Report/img/PosVelNF.tex', '-S400,300');

print('-dpdflatex', '../Report/img/PosVelF.tex', '-S300,250', '-mono');

figure(2)
plot(thet(:,1),thet(:,2),'k','linewidth',1)
xlabel('Posición ($\theta$)','Interpreter','latex')
ylabel('Velocidad ($\dot{\theta}$)','Interpreter','latex')
title('Retrato fase $\theta / \dot{\theta}$','Interpreter','latex')

set(gcf,'Color',[1 1 1])
##grid on
print('-dpdflatex', '../Report/img/faseF.tex', '-S300,200', '-mono');


%% Simulacion de pendulo
X = l*sin(thet(:,1));
Y = -l*cos(thet(:,1));


end

%% Funcion para ODE45
function dx = pendulo(~,x,l,m,k)
%Parametros del pendulo
g = 9.81;       % Gravedad (m/s^2)

dx(1) = x(2);
dx(2) = -(g/l)*sin(x(1)) - (k/m)*x(2);
dx = dx';
end