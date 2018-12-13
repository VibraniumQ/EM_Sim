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
x1 = MC.Lls*(2*pi*MC.f);
x2p = MC.Llr*(2*pi*MC.f);

s= 0:0.0001:1;
ns = 120 * f1./poles;
nr=ns*(1-s);
U1 = U1n*[1,0.8,0.6];
T_em = zeros(size(U1,2),size(s,2));
for i = 1:size(U1,2)
T_em(i,:) = NumPh*poles/(4*pi*f1)*U1(i)^2*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2);
end
figure;hold on
plot(T_em,nr,'LineWidth',1)
