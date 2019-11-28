clear
clc
close all

load Pendulo.mat;

t = linspace(1, 500, 500);

figure(1)
plot(t,(-angle*pi/180),'k','linewidth',1)
##xlim([0 15])
##ylim([-12 12])
xlabel('Tiempo','Interpreter','latex')
ylabel('$\theta$','Interpreter','latex')
##legend({'  $\theta$','  $\dot{\theta}$'},'Interpreter','latex','location', 'northeast', 'orientation', 'horizontal')
legend('boxoff')
title('Posición angular del péndulo','Interpreter','latex')
set(gcf,'Color',[1 1 1])
##grid on

##print('-dpdflatex', '../Report/img/PosVelNF.tex', '-S400,300');

print('-dpdflatex', '../Report/img/lego.tex', '-S300,250', '-mono');
