load_system('PC_nt')
set_param('PC_nt','SaveFinalState','on','FinalStateName',...
'myOperPoint','SaveCompleteFinalSimState','on');
set_param('PC_nt/Asynchronous Machine SI Units','Stator','[0.1 0.000867]',...
    'Rotor','[0.058 0.000867]','PolePairs','2','NominalParameters','[37300 400 50]',...
    'Mechanical','[0.4 0.02187 2]','Lm','0.03039')
simOut = sim('PC_nt','StopTime','1');
data1 = simOut.logsout{1}.Values.Data;
time1 = simOut.logsout{1}.Values.Time;

set_param('PC_nt','LoadInitialState','on','InitialState',...
'simOut.myOperPoint');
set_param('PC_nt/Asynchronous Machine SI Units','Stator','[0.025 0.000217]',...
    'Rotor','[0.014 0.000217]','PolePairs','1','NominalParameters','[43070 230 50]',...
    'Mechanical','[0.4 0.02187 1]','Lm','0.00759')
simOut = sim('PC_nt','StopTime','2');
data1 = [data1;simOut.logsout{1}.Values.Data];
time1 = [time1;simOut.logsout{1}.Values.Time];
set_param('PC_nt','LoadInitialState','off')


set_param('PC_nt','SaveFinalState','on','FinalStateName',...
'myOperPoint','SaveCompleteFinalSimState','on');
set_param('PC_nt/Asynchronous Machine SI Units','Stator','[0.1 0.000867]',...
    'Rotor','[0.058 0.000867]','PolePairs','2','NominalParameters','[37300 400 50]',...
    'Mechanical','[0.4 0.02187 2]','Lm','0.03039')
simOut = sim('PC_nt','StopTime','1');
data2 = simOut.logsout{1}.Values.Data;
time2 = simOut.logsout{1}.Values.Time;

set_param('PC_nt','LoadInitialState','on','InitialState',...
'simOut.myOperPoint');
set_param('PC_nt/Asynchronous Machine SI Units','Stator','[0.025 0.000217]',...
    'Rotor','[0.014 0.000217]','PolePairs','1','NominalParameters','[37300 400 50]',...
    'Mechanical','[0.4 0.02187 1]','Lm','0.00759')
simOut = sim('PC_nt','StopTime','2');
data2 = [data2;simOut.logsout{1}.Values.Data];
time2 = [time2;simOut.logsout{1}.Values.Time];

figure(1);plot(time1,data1)
title('三角形联结变双星形联结')
xlabel('时间 t/s');ylabel('转速 n/r·min^{-1}');
figure(2);plot(time2,data2)
title('星形联结变双星形联结')
xlabel('时间 t/s');ylabel('转速 n/r·min^{-1}');
set_param('PC_nt','LoadInitialState','off')
