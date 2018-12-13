hd = load_system('sRes_TN');
pt_num = 30;
Tem = zeros(1,pt_num);
R = [0.000001,1:1:4];
line_num = size(R,2);
figure;hold on;title('三相绕线式异步电机串电阻情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend
for j = 1:line_num
    w_max = 60*50/2;
    w = horzcat(linspace(0,w_max*1/3,5),linspace(w_max*(1/3+1/30),w_max,25));
    set_param('sRes_TN/SeriesR','Resistance',num2str(R(j)))
    for i = 1:pt_num
        tic
        str = num2str(w(i));
        set_param('sRes_TN/Constant','Value',str)
        sim('sRes_TN');
        Tem(i) = sum(logsout{1}.Values.Data)/10000;
        count_sims = sprintf('\n已生成第%d根图线的第%d个数据点',j,i);
        disp(count_sims)
        toc
    end
    plot(Tem,w,'-o','LineWidth',1,'MarkerSize',4,'DisplayName',['R_{\Omega} = ',num2str(j-1),'\Omega'])
end
save_system(hd)
beep