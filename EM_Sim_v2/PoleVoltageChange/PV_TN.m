tic
clc
clear all
load('ASMparameters_SI.mat')
MC = Machines(18);
U1n = MC.V/sqrt(3);
NumPh = 3;
poles = 2*[2,3,5];
f1 = MC.f;
N_n = 1480;
r1 = MC.Rs;
r2p = MC.Rr*6;
X10 = MC.Lls*(2*pi*MC.f);
X20p = MC.Llr*(2*pi*MC.f);
ns = 120 * f1./poles;

U1 = linspace(400,280,4);
s= 0:0.0005:1;
nr=ns'*(1-s);
T_em = zeros(3,3,2001);
figure;hold on
for j = 1:4
    for i = 1:3
        T_em(j,i,:) = NumPh*poles(i)/(4*pi)*(U1(j)/f1).^2*(f1*r2p./s./((r1+r2p./s).^2+(X10+X20p)^2));
    end
end
line = [squeeze(T_em(1,:,:));squeeze(T_em(2,:,:));squeeze(T_em(3,:,:));squeeze(T_em(4,:,:))];

line_p = zeros(12,1501);
for i = 1:12
    if mod(i,3)==1
        line_p(i,:) = spline(nr(1,2:end),line(i,2:end),1500:-1:0);
    elseif mod(i,3)==2
        line_p(i,:) = horzcat(NaN(1,500),spline(nr(2,2:end),line(i,2:end),1000:-1:0));
    else
        line_p(i,:) = horzcat(NaN(1,900),spline(nr(3,2:end),line(i,2:end),600:-1:0));
    end
end
line_pp = line_p;
line_pp(1,line_p(1,:)<line_p(2,:)) = nan;
line_pp(4,line_p(4,:)<line_p(2,:)) = nan;
line_pp(7,line_p(7,:)<line_p(2,:)) = nan;
line_pp(10,line_p(10,:)<line_p(2,:)) = nan;
line_pp(2,line_p(2,:)<line_p(3,:)) = nan;
line_pp(5,line_p(5,:)<line_p(3,:)) = nan;
line_pp(8,line_p(8,:)<line_p(3,:)) = nan;
line_pp(11,line_p(11,:)<line_p(3,:)) = nan;
line_xx = line_p([1,2],:);
line_xx(1,line_p(1,:)>line_p(2,:)) = nan;
line_xx(1,isnan(line_p(2,:))) = nan;
line_xx(2,line_p(2,:)>line_p(3,:)) = nan;
line_xx(2,isnan(line_p(3,:))) = nan;
figure;hold on
plot(line_pp,1500:-1:0,'-','LineWidth',1)
plot(line_xx,1500:-1:0,'--','LineWidth',1)
title('多速电动机(2p = 4、6、10)在变极变压时的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');
xlim([0,8000])
toc