%function pendulin
%% Simulacion del pendulo
clear
clc
close all

%% Variables para ODE45
tspan = 0:(1/24):15;
l = 1.5;        % Largo del pendulo (m)
m = 2;          % Masa de la bola (kg)
k = 1;          % Coeficiente de friccion

p0 = [l*sind(90);0];         %x, dx

[t,x] = ode45(@(t,y)pendulo(t,y,l,m,k),tspan,p0);

figure('Name','Poscicion y Velocidad')
plot(t,x(:,1),'k',t,x(:,2),'k--','linewidth',1)
xlabel('Tiempo','Interpreter','latex','fontsize',16)
ylabel('$x / \dot{x}$','Interpreter','latex','fontsize',16)
legend({'$x$','$\dot{x}$'},'Interpreter','latex','Location','Southeast','fontsize',14)
title('Posicion/Velocidad péndulo','fontsize',18)
set(gcf,'Color',[1 1 1])
grid on

figure('Name','Retrato Fase')
plot(x(:,1),x(:,2),'k','linewidth',1)
xlabel('Posicion (x)','Interpreter','latex','fontsize',14)
ylabel('Velocidad ($\dot{x}$)','Interpreter','latex','fontsize',14)
title('Retrato fase $x / \dot{x}$','Interpreter','latex','fontsize',16)
set(gcf,'Color',[1 1 1])
grid on


%% Simulación de pendulo
simulacion(t,x,l,m)



%end


%% Funcion para ODE45
function dx = pendulo(~,x,l,m,k)
%Parametros del pendulo
g = 9.81;       % Gravedad (m/s^2)

dx(1) = x(2);
dx(2) = -(g/l)*sin(x(1)) - (k/m)*x(2);
dx = dx';
end

function simulacion(t,x,l,m)
pos(:,1) = x(:,1);
pos(:,2) = -sqrt(l^2 - x(:,1).^2);
str3 = strcat('l =    ', num2str(l));
str4 = strcat('m =    ', num2str(m));

fig = figure(3);
set(gcf, 'Position', get(0, 'Screensize'));
ax = [-l-.5 l+.5 -l-.5 .5];
axis (ax)
hold on
grid on

n = size(pos,1);
for i = 1:n
    cla(gca(fig));
    plot([0 pos(i,1)],[0 pos(i,2)],'k');
    
    str0 = strcat('t =   ',num2str(t(i)));
    str1 = strcat('x =   ',num2str(pos(i,1)));
    str2 = strcat('y =   ',num2str(pos(i,2)));
    text(l-.25,-l,str0,'Fontsize',16)
    text(l-.25,-l-.10,str1,'Fontsize',16)
    text(l-.25,-l-.20,str2,'Fontsize',16)
    text(0+.25,0+.25,str3,'Fontsize',18)
    text(0+.25,0+.15,str4,'Fontsize',18)
    
    viscircles(pos(i,:),.1);
    drawnow
    k(i) = getframe(fig);
    %pause(t(size(t,1)/n));
end
video = VideoWriter('Pendulo', 'MPEG-4');
video.FrameRate = 24;

open(video);
writeVideo(video, k);
close(video);
end