%% setSimuPropertiesMultiScen
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190801
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Description:  Settings of simulation for multiple scenarios
%-------------------------------------------------------------------------
function [set]=setSimuPropertiesMultiScen
%% Define Magnetic Scenario -------------------------------------------
set.scenarioDescription='Scenario Standard Test Multi';
% EQ3 results in 1D or 2D
set.dimension=2;

% Magnets and description
% Note: Default Origin for magnet is at x=y=z=0; max. 50 mm in x, y, z
%           |----------------------------------------------------------|
%           |    position    |  euler-angles (z,y,x)   | dimensions    |
%           |   x   y   z    |  yaw     pitch  roll]   | w   l   h     |  
%           |----------------------------------------------------------|
set.magnets=[   0 0 30        0  0   0      30  10  10 ];  ...
%           |----------------------------------------------------------|
%                 0  0   -20     180     0       0       30  10  10  ];...
% %           |----------------------------------------------------------|
%                 0   -15 15      0       0       0          30  10  10;...
% %           |----------------------------------------------------------|
%                  0 15   15      0       0       0          30  10  10];
%           |----------------------------------------------------------|            

% Workspace of interest, might be modified depending on magnets
set.workspace=[-20 20 -20 20 0 20]; 

set.zPlatformStep=5; % Steps of altitude for investigation

% Define MR characteristics, either by distance d or angle alpha
% Option 1: alpha
set.MR='alpha';
set.alpha=[-30,0,30];
% Option 2: distance d
% set.MR='d';
% set.d=[-18,0,18];

% Show ...
set.visBvecfield=1;         % B-vectorfield and physical magnet model
set.visExperimentresult=1;  % Experimental results (2D Plot)

% Define altitude in mm of magnetisation during fabrication process
set.altitudeMagnetisation=68;
 
% Step of Interpolation for B-field superpos, min 0.05
set.interpolStep=single(5); 
set.round=1; % rounding for _ digit after semicolon

%% Further Properties (default)
set.a=15;            % Set intervall of observation in x,y [-a,a]
set.peq=15;          % Set max. amount of points of equ. per alt and alpha
% Set properties for 1D fitting
set.fit_polynome='poly6';        % Fitting type: Polynome 6th order
set.fit_centscale='off';         % Fitting includig "Centering and Scaling"
set.fit_intervallsection=1;      % Fitting in intervall between [-a,a]
set.magneticAngleTolerance=0.01; % To find magnetic moment
set.dTolerance=set.interpolStep; % To find distance d
% set.zPlatform=set.workspaceScenarioLayout(5):set.zPlatformStep:set.workspaceScenarioLayout(6);
% Process modified settings of simulation
set=processSimuProperties(set);