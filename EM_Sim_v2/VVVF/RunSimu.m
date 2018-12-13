hd = load_system('VVVF_TN');
set_param(hd,'FastRestart','on')
pt_num = 30;
line_num = 5;
Tem = zeros(line_num,pt_num);
f = [50,40,30,20,10];
line_num = size(f,2);
figure(1);hold on;title('三相鼠笼式异步电机恒压频比(U/f=8)情况下变压变频调速的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend
for j = 1:line_num
    N_max = 60*f(j)/2;
    N = horzcat(linspace(0,N_max*(5/6),15),linspace(N_max*((5/6)+1/30),N_max,15));
    str_f = ['[',num2str(400*f(j)/50),' 0 ',num2str(f(j)),']'];
    set_param('VVVF_TN/VoltageSource','PositiveSequence',str_f)
    for i = 1:pt_num
        tic
        str = num2str(N(i));
        set_param('VVVF_TN/Constant','Value',str)
        simOut = sim('VVVF_TN');
        Tem(j,i) = sum(simOut.logsout{1}.Values.Data)/10000;
        count_sims = sprintf('\n已生成第%d根图线的第%d个数据点',j,i);
        disp(count_sims)
        toc
    end
    plot(Tem(j,:),N,'-o','LineWidth',1,'MarkerSize',4,'DisplayName',['f = ',num2str(f(j)),'Hz'])
end
set_param(hd,'FastRestart','off')
save_system(hd)
beep