%% Simulacion del pendulo
clear
clc

%% Variables para ODE45
tspan = [0 15];
p0 = [.5;0];

[t,x] = ode45(@pendulo,tspan,p0);

figure('Name','Poscicion y Velocidad')
plot(t,x(:,1),'b',t,x(:,2),'r--')
grid on

pos(:,1) = x(:,1);
pos(:,2) = -sqrt(.5^2 - x(:,1).^2);

figure('Name','Retrato Fase')
plot(x(:,1),x(:,2),'m')
grid on

fig = figure(3);
axis ([-1 1 -1 1])
hold on
grid on

%% Simulación de pendulo
n = size(pos,1);
for i = 1:n
    cla(gca(fig));
    plot([0 pos(i,1)],[0 pos(i,2)],'k')
    viscircles(pos(i,:),.1);
    drawnow
    pause(tspan(2)/n)
end

%% Funcion para ODE45
function dx = pendulo(~,x)
%Parametros del pendulo
l = .5; %Largo del pendulo (m)
m = 1; %Masa de la bola (kg)
g = 9.81; %Gravedad (m/s^2)
k = .1; %Coeficiente de friccion

dx(1) = x(2);
dx(2) = -(g/l)*sin(x(1)) - (k/m)*x(2);
dx = dx';
end