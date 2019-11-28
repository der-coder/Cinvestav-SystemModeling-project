function octave_hamiltonian
%% Simulacion del pendulo
clear
clc
close all
%% Variables para ODE45
tspan = [0 15];
theta = pi/2;
p0 = [0 theta ];         %theta, d_theta

[t,x] = ode45(@pendulo,tspan,p0,'-MaxStep','1e-50');

figure(1)
plot(t,x(:,2),'k',t,x(:,1),'k--')
xlim([0 15])
xlabel('Tiempo','Interpreter','latex')
ylabel('$\theta, p_{\theta}$','Interpreter','latex')
legend({'  $\theta$','  $p_{\theta}$'},'Interpreter','latex','location', 'south', 'orientation', 'horizontal')
legend('boxoff')
title('Posición/Momento péndulo')
set(gcf,'Color',[1 1 1])
##grid off

print('-dpdflatex', '../Report/img/PosVelHamilton.tex', '-S300,250','-mono');

figure(2)
plot(x(:,2),x(:,1),'k')
xlabel('Posición $\theta$')
ylabel('Momento $p_{\theta}$')
title('Retrato fase $\theta / p_{\theta}$','Interpreter','latex')
set(gcf,'Color',[1 1 1])

print('-dpdflatex', '../Report/img/faseHamilton.tex', '-S300,200','-mono');
##grid on
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
