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

line_num = 50;
intern = 250;
line1 = 10;
U1 = horzcat(linspace(400,intern,line1),linspace(intern,180,line_num-line1))/sqrt(3);
delta_s = 0.0001;
s= 0:delta_s:1;
s = s';
nr=ns*(1-s);

figure;hold on
T_em = NumPh*poles/(4*pi).*(U1/f1).^2.*(f1*r2p./s./((r1+r2p./s).^2+(X10+X20p)^2)); 
plot(T_em,nr,'-','LineWidth',1)
title('三相鼠笼式异步电机变压调速下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');
plot([242.533,242.533],[0,1500],'r--','LineWidth',1)

[MaxT,Id_MaxT] = max(T_em);
id = find(MaxT<242.533,1);
U_min = 200+(intern-200)/(line_num-line1)*(line_num-id);
N_min = (1-(Id_MaxT(id)-1)*delta_s)*(60*f1/2);
D = 1480/N_min;
fprintf('调速范围为%f\n',D)