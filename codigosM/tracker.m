close all
clear all
clc

data = csvread('Pendulum.csv');

t = data(:,1);
omega = data(:,3);
theta = data(:,4);
alpha = data(:,5);

friction = 0.1:0.05:0.3;
mass = 0.1232109;
length = 0.193;
g = 9.81;
phi = theta(1);

model = -(g/length)*sin(theta+phi) + (friction/mass).*omega;

error = abs(model - alpha);

figure(11)
plot(t, error)

figure(1)
plot(t, alpha, 'k', t, model, 'ok', t, error, '--k')
%%
%%figure(2)
%%plot(t, alpha, 'k', t, model(:,2), 'ok')
%%
%%figure(3)
%%plot(t, alpha, 'k', t, model(:,3), 'ok')
%%
%%figure(4)
%%plot(t, alpha, 'k', t, model(:,4), 'ok')
%%
%%figure(5)
%%plot(t, alpha, 'k', t, model(:,5), 'ok')