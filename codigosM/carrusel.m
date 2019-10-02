function carrusel
close all
clear
clc

R = 5;
x0 = R*cos(pi/4);
y0 = R*sin(pi/4);

c_in = [x0,0,y0,0];                 % Condiciones iniciales x,dx,y,dy
t_span = [0 10];

[t,j] = ode45(@carr,t_span,c_in);

figure(1)
plot(t,j(:,1),'r',t,j(:,3),'b')
grid on

figure(2)
plot(j(:,1),j(:,2),'b')
grid on

figure(3)
plot(j(:,3),j(:,4),'b')
grid on

X = j(:,1);
Y = j(:,3);

w = 5;

x =  X.*cos(w*t) + Y.*sin(w*t);
y = -X.*sin(w*t) + Y.*cos(w*t);

figure(4)
plot(x,y);
grid on


end

function dx = carr(~,x)

w = 5;              % Velocidad angular 5 rad/sec
dx = ones(4,1);

dx(1) = x(2);
dx(2) = (w^2)*x(1) - 2*w*x(4);

dx(3) = x(4);
dx(4) = (w^2)*x(3) + 2*w*x(2);


%dx = dx';

end