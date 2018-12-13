hd = load_system('VC_TN');
set_param(hd,'FastRestart','on')
pt_num = 30;
Tem = zeros(1,pt_num);
U1 = 400:-50:200;
line_num = size(U1,2);
figure;hold on;title('��������ʽ�첽�����ѹ�����µĻ�е����');legend
xlabel('ת�� T_{em}/N��m');ylabel('ת�� n/r��min^{-1}');
for j = 1:line_num
    w_max = 60*50/2;
    w = horzcat(linspace(0,w_max*(5/6),15),linspace(w_max*((5/6)+1/30),w_max,15));
    str_f = ['[',num2str(U1(j)),' 0 50]'];
    set_param('VC_TN/VoltageSource','PositiveSequence',str_f)
    for i = 1:pt_num
        tic
        str = num2str(w(i));
        set_param('VC_TN/Constant','Value',str)
        simOut = sim('VC_TN');
        Tem(i) = sum(simOut.logsout{1}.Values.Data)/10000;
        count_sims = sprintf('\n�����ɵ�%d��ͼ�ߵĵ�%d�����ݵ�',j,i);
        disp(count_sims)
        toc
    end
    plot(Tem,w,'-o','LineWidth',1,'MarkerSize',4,'DisplayName',['U = ',num2str(U1(j)),'V'])
end
set_param(hd,'FastRestart','off')
save_system(hd)
beep