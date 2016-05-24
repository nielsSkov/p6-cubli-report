%----- IMPORTING TEST-DATA ------------------------------------------------
testData = csvread('PRINT_03.CSV');% <-- simTime=3.75
t = (testData(:,1)'+5)';
Yvolt = testData(:,2);

%Data from Volt to radians
Vmin = 0.4708;    %   mean(voltage( 667:1243,1)) %voltage mean from 3.3 to 6.2 in time
Vmax = 0.9513;    %   mean(voltage(1336:2000,1)) %voltage mean from 6.7 to 10 in time
equVolt = 0.6945; %   mean(voltage(   1: 591,1)) %voltage mean from 0 to 2.9 in time
resRad = (1.5769)/(Vmax-Vmin);
Y = (Yvolt - equVolt)*resRad-0.005;

%------- PLOT OF TEST DATA ------------------------------------------------
figure(1);
scatter(t,Y, 'b', '.');
hold on;

%----- CUBLI PARAMETERS ---------------------------------------------------
J_w=0.601e-3;
B_w=17.03e-6;
m_w=0.222;
l_w=0.093;
m_f=0.77-m_w;
l_f=0.08498;
g=9.82;

J_f=0.0048;
B_f=0.0078;
errn=27.5411;

%----- SIMULATION ---------------------------------------------------------
warning('off', 'all');
sim('CubliParameterEstimation.slx');
warning('on', 'all');

Ym=simOut;

%----- PLOT OF THE FINAL FIT ----------------------------------------------
plot(t,Ym,'r','linewidth',1.2);
grid on, grid minor;
title('Parameter Estimation of Cubli')
xlabel('Time (s)')
ylabel('Angular Position (rad)')
legend('Test data', 'Estimation', 'Location', 'SouthEast');
errorSTR = ['Normed RMS Error = ', num2str(errn), ' %'];
tex = text(0.52, 0.13,        ...
               errorSTR,              ...
               'Color', '[ 0 .55 0 ]',...
               'FontSize', 12);