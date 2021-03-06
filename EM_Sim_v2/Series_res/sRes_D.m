tic
clc
clear all
load('ASMparameters_SI.mat')
MC = Machines(18);
U1n = MC.V/sqrt(3);
NumPh = 3;
poles = 2*MC.ppole;
f1 = MC.f;
r1 = 1.405;
r2p = 1.395;
X10 = 0.005839*(2*pi*MC.f);
X20p = 0.005839*(2*pi*MC.f);
ns = 120 * f1/poles;
s= 0:0.0005:1;
nr=ns*(1-s);

line_num = 10;
line1 = 4;
intern = 4;
r_c = horzcat(linspace(0,intern,line1),linspace(intern,42,line_num-line1));
figure;hold on
T_em = NumPh*poles/(4*pi)*(U1n/f1).^2*(f1*(r2p+r_c')./s./((r1+(r2p+r_c')./s).^2+(X10+X20p)^2)); 
plot(T_em,nr,'-','LineWidth',1)
title('三相绕线式异步电机串电阻调速情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');
plot([8.867,8.867],[0,1500],'r--','LineWidth',2)

toc