close;clc;clear
tic
hd = load_system('VVVF_TN');
set_param(hd,'StopTime','2','FastRestart','on')
pt_num = 30;
line_num = 5;
f = linspace(50,10,line_num);
figure(1);hold on;title('三相鼠笼式异步电机恒压频比(U/f=8)情况下变压变频调速的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend

in(1:pt_num,1:line_num) = Simulink.SimulationInput('VVVF_TN');
N_max = 60*f/2;
itn = 0.7; % internal
part_a = 15;
N = transpose(reshape(cell2mat(arrayfun(@(i)horzcat(linspace(0,N_max(i)*itn,part_a),linspace(N_max(i)*itn,N_max(i),pt_num-part_a)),1:line_num,'UniformOutput',false)),pt_num,line_num));
str_f = reshape(arrayfun(@(i)['[',num2str(400*f(i)/50),' 0 ',num2str(f(i)),']'],1:line_num,'UniformOutput',false),[],1);
in = arrayfun(@(j)arrayfun(@(i)in(i,j).setBlockParameter('VVVF_TN/VoltageSource','PositiveSequence',cell2mat(str_f(j)),...
        'VVVF_TN/Constant','Value',num2str(N(j,i))),1:pt_num),1:line_num,'UniformOutput',false);
in = reshape(transpose(cat(1,in{:})),1,[]);
out = parsim(in,'ShowProgress','on','ShowSimulationManager', 'on');
Tem = transpose(reshape(cell2mat(arrayfun(@(j)arrayfun(@(i)mean(out(pt_num*(j-1)+i).logsout{1}.Values.Data),1:pt_num),1:line_num,'UniformOutput',false)),pt_num,line_num));
arrayfun(@(i)plot(Tem(i,:),N(i,:),'-o','LineWidth',1,'MarkerSize',4,'DisplayName',['f = ',num2str(f(i)),'Hz']),1:line_num)
set_param(hd,'FastRestart','off')
save_system(hd)
save('vvvf_TN_data.mat','Tem','N','f')
toc
beep