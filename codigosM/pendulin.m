function pendulin
%% Simulacion del pendulo
clear
clc
close all

%% Variables para ODE45
tspan = [0 15];

l = 2.5;        % Largo del pendulo (m)
m = 5;          % Masa de la bola (kg)
k = 1;          % Coeficiente de friccion
theta = pi/2;

p0 = [theta 0];         %theta, d_theta

[t,thet] = ode45(@(t,y)pendulo(t,y,l,m,k),tspan,p0);

figure('Name','Poscicion y Velocidad')
plot(t,thet(:,1),'k',t,thet(:,2),'k--','linewidth',3)
xlabel('Tiempo','Interpreter','latex','fontsize',16)
ylabel('$/theta / \dot{?theta}$','Interpreter','latex','fontsize',16)
legend({'$x$','$\dot{x}$'},'Interpreter','latex','Location','Southeast','fontsize',14)
title('Posicion/Velocidad péndulo','fontsize',18)
set(gcf,'Color',[1 1 1])
grid on

figure('Name','Retrato Fase')
plot(thet(:,1),thet(:,2),'k','linewidth',3)
xlabel('Posicion (x)','Interpreter','latex','fontsize',14)
ylabel('Velocidad ($\dot{x}$)','Interpreter','latex','fontsize',14)
title('Retrato fase $x / \dot{x}$','Interpreter','latex','fontsize',16)
set(gcf,'Color',[1 1 1])
grid on


%% Simulación de pendulo
X = l*sin(thet(:,1));
Y = -l*cos(thet(:,1));
simulacion(t,X,Y,l)

end


%% Funcion para ODE45
function dx = pendulo(~,x,l,m,k)
%Parametros del pendulo
g = 9.81;       % Gravedad (m/s^2)

dx(1) = x(2);
dx(2) = -(g/l)*sin(x(1)) - (k/m)*x(2);
dx = dx';
end

function simulacion(t,x,y,l)

x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);

str0 = string(strcat('t = ',num2str(round(t,2))));
str1 = string(strcat('x = ',num2str(round(x,2))));
str2 = string(strcat('y = ',num2str(round(y,2))));

fig = figure(3);
set(gcf, 'Position', get(0, 'Screensize'));
ax = [x_min-.5 x_max+.5 y_min-.5 y_max+.5];
axis (ax)
hold on
grid on

n = size(t,1);
for i = 1:n
    cla(gca(fig));
    plot([0 x(i)],[0 y(i)],'k');
    text(l-.25,-l,str0(i),'Fontsize',16)
    text(l-.25,-l-.10,str1(i),'Fontsize',16)
    text(l-.25,-l-.20,str2(i),'Fontsize',16)
    pos = [x(i) y(i)];
    viscircles(pos,.1);
    drawnow
%     k(i) = getframe(fig);
    %pause(1/30)
end
% video = VideoWriter('Pendulo', 'MPEG-4');
% video.FrameRate = 30;
% open(video);
% writeVideo(video, k);
% close(video);
close (fig)
end