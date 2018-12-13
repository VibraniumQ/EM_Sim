hd = load_system('VC_eta');
set_param(hd,'FastRestart','on')
pt_num = 20;
eta = zeros(1,pt_num);
U1 = linspace(400,240,pt_num);
set_param('VC_eta/Constant','Value','242.533')
figure(1);hold on;title('额定转矩下变压调速效率')
xlabel('定子电压 U/V');ylabel('效率 \eta')
xlim([240,400]);ylim([0.8,1])
ax = gca;
ax.XDir = 'reverse';
for i = 1:pt_num
    tic
    str_f = ['[',num2str(U1(i)),' 0 50]'];
    set_param('VC_eta/VoltageSource','PositiveSequence',str_f)
    simOut = sim('VC_eta');
    eta(i) = sum(simOut.logsout{1}.Values.Data)/10000;
    count_sims = sprintf('\n已生成第%d个数据点',i);
    disp(count_sims)
    toc
end
plot(U1,eta,'-o','LineWidth',1,'MarkerSize',4)
set_param(hd,'FastRestart','off')
save_system(hd)
beep
