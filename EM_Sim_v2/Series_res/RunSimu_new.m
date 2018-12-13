% This method seems to be wrong
% Waiting for another review

hd = load_system('sRes_TN');
R = [0.000001,1:1:4];
set_param('sRes_TN','SaveFinalState','on','FinalStateName',...
    'myOperPoint','SaveCompleteFinalSimState','on');
set_param('sRes_TN','LoadInitialState','off')

set_param('sRes_TN/SeriesR','Resistance',num2str(R(1)))
set_param(hd,'StopTime','2')
sim('sRes_TN')
data=[logsout{1}.Values.Data];
time=[logsout{1}.Values.Time];
set_param('sRes_TN','LoadInitialState','on','InitialState',...
    'myOperPoint');

for i = 2:size(R,2)
    set_param('sRes_TN/SeriesR','Resistance',num2str(R(i)))
    sim('sRes_TN','StopTime',num2str(2*i))
    data = [data;logsout{1}.Values.Data];
    time = [time;logsout{1}.Values.Time];
end
% set_param('sRes_TN','LoadInitialState','on','InitialState',...
% 'simOut.myOperPoint');
% set_param('sRes_TN/SeriesR','Stator','[0.025 0.000217]',...
%     'Rotor','[0.014 0.000217]','PolePairs','1','NominalParameters','[43070 230 50]',...
%     'Mechanical','[0.4 0.02187 1]','Lm','0.00759')
% simOut = sim('sRes_TN','StopTime','2');
% data1 = [data1;simOut.logsout{1}.Values.Data];
% time1 = [time1;simOut.logsout{1}.Values.Time];
set_param('sRes_TN','LoadInitialState','off')

figure(1);plot(time,data)
xlabel('时间 t/s');ylabel('转速 n/r·min^{-1}');