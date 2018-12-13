tic
clc
clear all
load('ASMparameters_SI.mat')
MC = Machines(18);
U1n = MC.V/sqrt(3);
NumPh = 3;
poles = 2*MC.ppole;
f1 = MC.f;
N_n = 1480;
r1 = MC.Rs;
r2p = MC.Rr;
X10 = MC.Lls*(2*pi*MC.f);
X20p = MC.Llr*(2*pi*MC.f);
Xm0 = MC.Lm*(2*pi*MC.f);

f = [50,40,30,20,10];
nr = zeros(2001,size(f,2));
T_em = zeros(2001,size(f,2));
for cnt = 1:size(f,2)
    ns = 120 * f(cnt)/poles;
    x1 = X10 *(f(cnt)/f1);
    x2p = X20p * (f(cnt)/f1);
    U1 = U1n *(f(cnt)/f1);
    s= 0:0.0005:1;
    nr(:,cnt)=ns*(1-s);
    T_em(:,cnt) = NumPh*poles/(4*pi)*(U1/f(cnt))^2*(f(cnt)*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2));
end
plot(T_em,nr,'-','LineWidth',1)
title('三相鼠笼式异步电机恒压频比情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');
legend('f = 50','f = 40','f = 30','f = 20','f = 10')
figure
plot(T_em,s,'-','LineWidth',1)
title('三相鼠笼式异步电机恒压频比情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转差率 s');
legend('f = 50','f = 40','f = 30','f = 20','f = 10')
ax = gca;
ax.YDir = 'reverse';

f = 50:-1:10;
nr = zeros(2001,size(f,2));
T_em = zeros(2001,size(f,2));
for cnt = 1:size(f,2)
    ns = 120 * f(cnt)/poles;
    x1 = X10 *(f(cnt)/f1);
    x2p = X20p * (f(cnt)/f1);
    U1 = U1n *(f(cnt)/f1);
    s= 0:0.0005:1;
    nr(:,cnt)=ns*(1-s);
    T_em(:,cnt) = NumPh*poles/(4*pi)*(U1/f(cnt))^2*(f(cnt)*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2));
end
figure
[X,Y] = meshgrid(f,s);
surf(X,Y,T_em,'EdgeColor','flat')
xlabel('频率 f/s^{-1}');ylabel('转差率 s');zlabel('转矩 T_{em}/N·m')
toc