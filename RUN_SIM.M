% This script will configure and run the simulation.

disp( '#######################' );

%% first simulation run
% update model parameters
disp( 'Updating model parameters.' );

% run simulation
%Racing Sim

prepare_sim();

%Racing Parameters

roll_fric = 0.003;
area = 0.3800;
air_drag = 0.4000;

simOut1 = sim('ebike');
simout_1 = simOut1.get('simout'); 

% compute statistics from simulation result
t1=simout_1.time;    % Time 
r1=simout_1.signals.values(:,1); % Residual Power
me1=simout_1.signals.values(:,2); % Motor Energy
de1=simout_1.signals.values(:,3); % Driver Energy
tot1=simout_1.signals.values(:,4); %Power Total
mp1=simout_1.signals.values(:,5);% Motor Power
v=simout_1.signals.values(:,9); % Velocity


%% second simulation run
% update model parameters
disp( 'Updating model parameters.' );
% run simulation
%Standard Sim

prepare_sim();

%Standard Parameters

roll_fric = 0.006;
area = 0.5;
air_drag = 1.1;

simOut2 = sim('ebike');
simout_2 = simOut2.get('simout1');

% compute statistics from simulation result
t2=simout_2.time;    % Time 
r2=simout_2.signals.values(:,1); % Residual Power
me2=simout_2.signals.values(:,2); % Motor
de2=simout_2.signals.values(:,3); % Driver
tot2=simout_2.signals.values(:,4); %Power Total
mp2=simout_2.signals.values(:,5);% Motor Power

% Modification Model in Simulink
% Task 7 - SubTask No. 4 - Adapt the model to consider the rule, that above
% a velocity of 25 km/h the motor support will be shut off.

% Graph Plots

figure 


subplot(5,2,1);
plot(t1,r1,'g');
title('Residue Power Left For Racing Mode With Motor Control Modification ');

subplot(5,2,3);
plot(t1,v,'g');
title('Velocity');

subplot(5,2,5);
plot(t1,me1,'g');
title('Motor Energy Consumed For Racing Mode');

subplot(5,2,7);
plot(t1,de1,'g');
title('Driver Energy Consumed For Racing Mode');

subplot(5,2,9);
plot(t1,tot1,'g');
title('Total Energy Consumed For Racing Mode');



subplot(5,2,2);
plot(t2,r2);
title('Residue Left For Standard Mode With Motor Control Modification');

subplot(5,2,4);
plot(t1,v);
title('Velocity');

subplot(5,2,6);
plot(t2,me2);
title('Motor Energy Consumed For Standard Mode');

subplot(5,2,8);
plot(t2,de2);
title('Driver Energy Consumed For Standard Mode');

subplot(5,2,10);
plot(t2,tot2);
title('Total Energy Consumed For Standard Mode');



%% further simulation runs
% ...

disp('#######################');
disp('Racing Mode:');
disp('Total Energy Used is');
disp(simout_1.signals.values(328,4));

disp('Rolling friction : 0.003');
disp('Air drag coefficient : 0.4');
disp('Frontal area : 0.38 m^2');
 
disp('#######################');
disp('#######################');

disp('Standard Mode:');
disp('Total Energy Used is');
disp(simout_2.signals.values(328,4));

disp('Rolling friction : 0.006');
disp('Air drag coefficient : 1.1');
disp('Frontal area : 0.5 m^2');


%% clean up workspace
disp( 'Cleaning up Workspace.' );
% clear parameters
clearvars; 
% clear simulation output
Simulink.sdi.clear;
disp( 'Done.' );
disp( '#######################' );
disp( '#######################' );