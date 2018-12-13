hd = load_system('VVVF_eta');
set_param(hd,'FastRestart','on')
pt_num = 20;
eta = zeros(1,pt_num);
f = linspace(50,10,pt_num);
set_param('VVVF_eta/Constant','Value','242.533')
figure(1);hold on;title('��ѹƵ��(U/f=8)����Ч�ʱ仯ͼ')
xlabel('Ƶ�� f/s^{-1}');ylabel('Ч�� \eta')
xlim([0,50]);ylim([0,1])
ax = gca;
ax.XDir = 'reverse';
for i = 1:pt_num
    tic
    N_max = 60*f(i)/2;
    str_f = ['[',num2str(400*f(i)/50),' 0 ',num2str(f(i)),']'];
    set_param('VVVF_eta/VoltageSource','PositiveSequence',str_f)
    simOut = sim('VVVF_eta');
    eta(i) = sum(simOut.logsout{1}.Values.Data)/10000;
    count_sims = sprintf('\n�����ɵ�%d�����ݵ�',i);
    disp(count_sims)
    toc
end
plot(f,eta,'-o','LineWidth',1,'MarkerSize',4)
set_param(hd,'FastRestart','off')
save_system(hd)
beep
