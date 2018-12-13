tic
clear;clc;close
load('vvvf_TN_data.mat')
load_system('VVVF_nt')
drawPic(1,Tem,N,f)

simOut = sim('VVVF_nt','SignalLoggingName','Te_n');
Te = simOut.Te_n{1}.Values.Data;
n = simOut.Te_n{2}.Values.Data;

% plot(Te,n,'LineWidth',0.1,'DisplayName','T_{em}-n','Color',[0 .7 .7])
nt_line = animatedline('Color',[0 .7 .7],'DisplayName','T_{em}-n');
legend('AutoUpdate','off')
p = plot(Te(1),n(1),'o','MarkerFaceColor','red');
sp_t = 50; % Sample Time
loops = fix(size(Te,1)/sp_t);
F(loops) = struct('cdata',[],'colormap',[]);
for k = 1:size(Te,1)
    addpoints(nt_line,Te(k),n(k));
    p.XData = Te(k);
    p.YData = n(k);
    drawnow limitrate
    if mod(k,sp_t)==0
        F(fix(k/sp_t)) = getframe(gca);
    end
end

%% new figure for movie
drawPic(2,Tem,N,f)
movie(F,1,15)
save('myMovie.mat','F')
toc

function drawPic(hd_num,Tem,N,f)
fig = figure(hd_num);hold on;fig.GraphicsSmoothing = 'on';fig.Renderer = 'opengl';
title('三相鼠笼式异步电机恒压频比(U/f=8)情况下变压变频调速的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend('Location','northwest')
arrayfun(@(i)plot(Tem(i,:),N(i,:),'-o','LineWidth',2,'MarkerSize',5,'DisplayName',['f = ',num2str(f(i)),'Hz']),1:size(N,1))
plot([242.533,242.533],[0,1500],'r--','LineWidth',1,'DisplayName','额定转矩')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([-500 1000 0 1800])
end