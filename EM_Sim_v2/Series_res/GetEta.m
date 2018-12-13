hd = load_system('sRes_eta');
pt_num = 5;
eta = zeros(1,pt_num);
R = [0.000001,1:1:4];
set_param('sRes_eta/Constant','Value','50')
figure(1);hold on;title('串电阻调速电机效率曲线')
xlabel('串接电阻 R/\Omega');ylabel('效率 \eta')
xlim([0,4]);ylim([0,1])
for i = 1:pt_num
    tic
    set_param('sRes_eta/SeriesR','Resistance',num2str(R(i)))
    sim('sRes_eta');
    eta(i) = sum(logsout{1}.Values.Data)/10000;
    count_sims = sprintf('\n已生成第%d个数据点',i);
    disp(count_sims)
    toc
end
plot(R,eta,'-o','LineWidth',1,'MarkerSize',4)
save_system(hd)
beep
