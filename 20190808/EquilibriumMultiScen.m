% Equilibrium MultiScen: Positions of equilibrium
%------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Description:  Calculates poe for fixed water surface and moved MA
%------------------------------------------------------------------------

[setting]=setSimuProperties;

% Modify settings to match Experiment Scenario
setting.magnet(2,:)=[0 0 -20 90 0 0 30 10 10];  % Fix MB at MB=-20
setting.zPlatform=0;
setting.MR='d';
% setting.d=[-28,-18,-8,8,18,28];
 setting.d=[-28,28];
setting.MR_half=unique(abs(setting.d));
setting.zMA=15:2:35; % Same steps like in experiment, altitude Magnet Above

% Creates arrays for points of equilibria
[poe_1D_multi]=createPoe(setting,setting.MR_half,setting.MR_half,setting.zMA); % in 1D
[poe_2D_multi]=createPoe(setting,setting.MR_half,setting.MR_half,setting.zMA); % in 2D

for i_zMA=1:length(setting.zMA)
Equilibrium    
poe_new=load('poe.mat');
poe_1D_new=poe_new.poe_1D;
poe_2D_new=poe_new.poe_2D;

poe_1D_multi.xpos(:,i_zMA,:)=poe_1D_new.xpos;
poe_1D_multi.xcenter(1,i_zMA,:)=poe_1D_new.xcenter;
poe_1D_multi.xneg(:,i_zMA,:)=poe_1D_new.xneg;

poe_1D_multi.ypos(:,i_zMA,:)=poe_1D_new.ypos;
poe_1D_multi.ycenter(1,i_zMA,:)=poe_1D_new.ycenter;
poe_1D_multi.yneg(:,i_zMA,:)=poe_1D_new.yneg;

poe_2D_multi.xpos(:,i_zMA,:)=poe_2D_new.xpos;
poe_2D_multi.xcenter(1,i_zMA,:)=poe_2D_new.xcenter;
poe_2D_multi.xneg(:,i_zMA,:)=poe_2D_new.xneg;

poe_2D_multi.ypos(:,i_zMA,:)=poe_2D_new.ypos;
poe_2D_multi.ycenter(1,i_zMA,:)=poe_2D_new.ycenter;
poe_2D_multi.yneg(:,i_zMA,:)=poe_2D_new.yneg;
end
visualiseSimulation(setting,poe_1D,poe_2D,'zMA');


