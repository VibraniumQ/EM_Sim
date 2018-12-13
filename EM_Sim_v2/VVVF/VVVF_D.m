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

line_num = 60;
intern = 10;
line1 = 10;
f = horzcat(linspace(50,intern,line1),linspace(intern,0,line_num-line1));
delta_s = 0.0001;
nr = zeros(1/delta_s+1,size(f,2));
T_em = zeros(1/delta_s+1,size(f,2));
s= 0:delta_s:1;
s = s';
for cnt = 1:size(f,2)
    ns = 120 * f(cnt)/poles;
    x1 = X10 *(f(cnt)/f1);
    x2p = X20p * (f(cnt)/f1);
    U1 = U1n *(f(cnt)/f1);
    nr(:,cnt)=ns*(1-s);
    T_em(:,cnt) = NumPh*poles/(4*pi)*(U1/f(cnt))^2*(f(cnt)*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2));
end
plot(T_em,nr,'-','LineWidth',1);hold on
title('三相鼠笼式异步电机恒压频比(U/f=8)情况下的调速范围求解')
xlabel('转矩 T_{em}/N·cnt');ylabel('转速 n/r·min^{-1}');
plot([242.533,242.533],[0,1500],'r--','LineWidth',1)

[MaxT,Id_MaxT] = max(T_em);
id = find(MaxT<242.533,1);
f_min = 10/(line_num-line1)*(line_num-id);
N_min = (1-(Id_MaxT(id)-1)*delta_s)*(60*f_min/2);
D = 1480/N_min;
fprintf('调速范围为%f\n',D)
toc