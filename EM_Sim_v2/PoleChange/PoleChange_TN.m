tic
clc
clear all
load('ASMparameters_SI.mat')
MC = Machines(18);
U1n = MC.V/sqrt(3);
NumPh = 3;
poles = 2*MC.ppole*[2 2 1];
f1 = MC.f;
N_n = 1480;
r1 = MC.Rs;
r2p = MC.Rr;
x1 = MC.Lls*(2*pi*MC.f);
x2p = MC.Llr*(2*pi*MC.f);

s= -2:0.0001:1.5;
ns = 120 * f1./poles([1,2]);
nr=ns'*(1-s);
T_Y = NumPh*poles(1)/(4*pi*f1)*U1n^2*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2);
T_tri = NumPh*poles(2)/(4*pi*f1)*(sqrt(3)*U1n)^2*r2p./s./((r1+r2p./s).^2+(x1+x2p)^2);

s= -0.5:0.0001:1.4;
ns = 120 * f1./poles(3);
nr_yy=ns'*(1-s);
T_YY = NumPh*poles(3)/(2*4*pi*f1)*U1n^2*r2p./(4*s)./((r1/4+r2p./(4*s)).^2+(x1/4+x2p/4)^2);
figure(1)
plot(T_Y,nr(2,:),T_YY,nr_yy,'LineWidth',2)
legend('星形联结','双星形联结');title('星形联结改为双星形联结')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([-4000,4000]);ylim([-300,2240])
figure(2)
plot(T_tri,nr(2,:),T_YY,nr_yy,'LineWidth',2)
legend('三角形联结','双星形联结');title('三角形联结改为双星形联结')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
xlim([-10000,10000]);ylim([-300,2200])