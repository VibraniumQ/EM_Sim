tic
clc
clear all
load('ASMparameters_SI.mat')
MC = Machines(18);
NumPh = 3;
poles = 2*MC.ppole;
f1 = MC.f;
r1 = MC.Rs;
r2p = MC.Rr;
X10 = MC.Lls*(2*pi*MC.f);
X20p = MC.Llr*(2*pi*MC.f);
ns = 120 * f1/poles;

U1 = (400:-50:200)/sqrt(3);
s= 0:0.0005:1;
nr=ns*(1-s);
figure;hold on
T_em = NumPh*poles/(4*pi)*(U1'/f1).^2*(f1*r2p./s./((r1+r2p./s).^2+(X10+X20p)^2)); 
plot(T_em,nr,'-','LineWidth',1)
title('三相鼠笼式异步电机变压调速下的机械特性')
legend('U1 = 400V','U1 = 350V','U1 = 300V','U1 = 250V','U1 = 200V')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');

toc