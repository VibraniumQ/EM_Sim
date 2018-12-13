tic
clear;clc;close
load('sRes_TN_data_1Ohm.mat')
load_system('sRes_nt')
drawPic(1,Tem,N,R)

single_R = 1;
arrayfun(@(i)arrayfun(@(j)set_param(['sRes_nt/Time-variant Resistance/Subsystem',num2str(i),'/Series RLC Branch',num2str(j)],'Resistance',num2str(single_R)),0:2),1:5)

tic
simOut = sim('sRes_nt','SignalLoggingName','Te_n');
Te = simOut.Te_n{1}.Values.Data;
n = simOut.Te_n{2}.Values.Data;
toc

% plot(Te,n,'LineWidth',0.1,'DisplayName','T_{em}-n','Color',[0 .7 .7])
nt_line = animatedline('Color',[0 .7 .7],'DisplayName','T_{em}-n','LineWidth',2);
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
drawPic(2,Tem,N,R)
movie(F,1,15)
save('myMovie_1Ohm.mat','F')

function drawPic(hd_num,Tem,N,R)
fig = figure(hd_num);hold on;fig.GraphicsSmoothing = 'on';fig.Renderer = 'opengl';
title('三相绕线式异步电机串电阻情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend('Location','northeast')
arrayfun(@(i)plot(Tem(i,:),N(i,:),'-o','LineWidth',0.5,'MarkerSize',2,'DisplayName',['R = ',num2str(R(i)),'\Omega']),1:size(N,1))
plot([10,10],[0,1500],'r--','LineWidth',1,'DisplayName','额定转矩')
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([-15 200 0 1600])
end