%% visualiseExperiments
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Visualises all experimental results
%-------------------------------------------------------------------------
function visualiseExperiments(set)

if set.visExperimentresult==1
%% Single
% % Experiment 1
% % visualiseExperimentResults(set,M,'20190730_Exp1_MB13.txt',1);
% [sc,l]=visualiseExperimentResults_singled...
%     (0,'black','20190730_Exp1_MB13.txt',1);
% [sc,l]=visExpRes_singled(set,8,'b','20190730_Exp1_MB13.txt',1);
% [sc,l]=visExpRes_singled(set,18,'r','20190730_Exp1_MB13.txt',1);
% [sc,l]=visExpRes_singled(set,28,'g','20190730_Exp1_MB13.txt',1);
% 
% % Experiment 1
% %  visualiseExperimentResults(set,M,'20190730_Exp1_MB08.txt',1);
% [sc,l]=visExpRes_singled...
%     (set,0,'black','20190730_Exp1_MB08.txt',1);
% [sc,l]=visExpRes_singled(set,8,'b','20190730_Exp1_MB08.txt',1);
% [sc,l]=visExpRes_singled(set,18,'r','20190730_Exp1_MB08.txt',1);
% [sc,l]=visExpRes_singled(set,28,'g','20190730_Exp1_MB08.txt',1);

% % Experiment 2
% [sc,l]=visExpRes_singled(set,18,'r','20190805_Exp2_MB13.txt',2);
% [sc,l]=visExpRes_singled(set,26,'c','20190805_Exp2_MB13.txt',2);
% [sc,l]=visExpRes_singled(set,28,'g','20190805_Exp2_MB13.txt',2);  

%% All together 
figure('Name','Points of Equilibrium (2D) - Experiment 1')
% visualiseExperimentResults_entity(fig,'20190730_Exp1_MB13.txt',1)

% % Experiment 1
% [sc0,l0]=visExpRes_singled(set,0,'black','20190730_Exp1_MB13.txt',1);
% [sc08,l08]=visExpRes_singled(set,8,'b','20190730_Exp1_MB13.txt',1);
% [sc18,l18]=visExpRes_singled(set,18,'r','20190730_Exp1_MB13.txt',1);
% [sc28,l28]=visExpRes_singled(set,28,'g','20190730_Exp1_MB13.txt',1);

% % Experiment 1
[sc0,l0]=visExpRes_singled(set,0,'black','20190730_Exp1_MB08.txt',1);
[sc08,l08]=visExpRes_singled(set,8,'b','20190730_Exp1_MB08.txt',1);
[sc18,l18]=visExpRes_singled(set,18,'r','20190730_Exp1_MB08.txt',1);
[sc28,l28]=visExpRes_singled(set,28,'g','20190730_Exp1_MB08.txt',1);

% legend(,...
%     'Orientation','vertical','Location','southeast')
% %     'Orientation','vertical','Location','southoutside')  

% xlabel(['Distance from magnetic centre (x-axis) in mm'])
% ylabel(['Distance from magnetic centre (y-axis) in mm'])
% zlabel(['Altitude of platform (z-axis) in mm'])
end