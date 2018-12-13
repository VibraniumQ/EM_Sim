close;clc;clear
tic
hd = load_system('sRes_TN');
set_param(hd,'StopTime','2','FastRestart','on')
pt_num = 30;
line_num = 5;
least = 0;
largest = 4;
R = linspace(least,largest,line_num);
if least== 0, R(1) = 0.000001;end
figure(1);hold on;title('三相绕线式异步电机串电阻情况下的机械特性')
xlabel('转矩 T_{em}/N·m');ylabel('转速 n/r·min^{-1}');legend

in(1:pt_num,1:line_num) = Simulink.SimulationInput('sRes_TN');
N_max = 60*50/2;
itn = 0.7; % internal
part_a = 15;
N = transpose(reshape(cell2mat(arrayfun(@(i)horzcat(linspace(0,N_max*itn,part_a),linspace(N_max*itn,N_max,pt_num-part_a)),1:line_num,'UniformOutput',false)),pt_num,line_num));
str_R = reshape(arrayfun(@(i)num2str(R(i)),1:line_num,'UniformOutput',false),[],1);
in = arrayfun(@(j)arrayfun(@(i)in(i,j).setBlockParameter('sRes_TN/SeriesR','Resistance',cell2mat(str_R(j)),...
        'sRes_TN/Constant','Value',num2str(N(j,i))),1:pt_num),1:line_num,'UniformOutput',false);
in = reshape(transpose(cat(1,in{:})),1,[]);
out = parsim(in,'ShowProgress','on','ShowSimulationManager', 'on');
Tem = transpose(reshape(cell2mat(arrayfun(@(j)arrayfun(@(i)mean(out(pt_num*(j-1)+i).logsout{1}.Values.Data),1:pt_num),1:line_num,'UniformOutput',false)),pt_num,line_num));
R = linspace(least,largest,line_num);
arrayfun(@(i)plot(Tem(i,:),N(i,:),'-o','LineWidth',1,'MarkerSize',4,'DisplayName',['R = ',num2str(R(i)),'\Omega']),1:line_num)
set_param(hd,'FastRestart','off')
save_system(hd)
save('sRes_TN_data_1Ohm.mat','Tem','N','R')
toc
beep