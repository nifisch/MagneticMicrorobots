%% setSimuProperties
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Settings of simulation
%-------------------------------------------------------------------------
function [set]=setSimuProperties
%% Define Magnetic Scenario
set.scenarioDescription='Scenario Standard';
set.simulationFlavour='quick'; % QUICK and dirty/ SLOW and proper

set.workspace=[-20 20 -20 20 0 30];% Workspace of interest, 
set.dimension=1;        % POE results in 1D (1) or 2D (2)
set.polynomial=0;       % Use analytical approach (1), default: numerical
set.zPlatformStep=5;    % Steps of altitude for investigation
set.magmommeasured=0;   % B measured for M (1), default: simulate M
set.altitudeMagnetisation=68;   % Altitude in mm magnet during fabrication 
set.MR='d';             % Option 1: distance d
% set.d=[-28,-18-8,8,18,28];
set.d=[-20,20];
% Finetuning ...
set.interpolStep=single(5);   % Interpolation B-field superpos, min 0.05
set.interpolStepM=single(1);    % Interpolation Magn. Moment M
% Show ...
set.visBvecfield=0;               % B-vectorfield
set.visMagnets=0;                 % Magnets
set.vis1Dfit=0;                   % Fitting procedue in 1D
set.vis2Dfit=0;                   % Fitting procedue in 2D
set.visSurfaceplotExtrema=0;	  % Surface(f) and extrema	
set.visExperimentresult=0;        % Experimental results (2D plot)
set.visExperimentresult_entity=1; % Experimental results in 1 plot

% Permanent Magnets (PMs)
%           |----------------------------------------------------------|
%           |    position    |  euler-angles (z,y,x)   | dimensions    |
%           |   x   y   z    |  yaw     pitch  roll]   | w   l   h     |  
%           |----------------------------------------------------------|
set.magnets=[   0 0 30        0  0   0      30  10  10 ];  ...
%           |----------------------------------------------------------|
%                 30  -30   30     45     0       0       30  10  10  ;...
% %         |----------------------------------------------------------|
%                 -30   0 30      0       0       0          30  10  10;...
%         |----------------------------------------------------------|
%                  -30 -30   30      -45      0       0          30  10  10];
%           |----------------------------------------------------------|    
% set.MR='alpha';       % Option 2: alpha
% set.alpha=[-15,0,15];
%% Further Properties (default)
set.a=15;            % Set intervall of observation in x,y [-a,a]
set.peq=15;          % Set max. amount of points of equ. per alt and alpha
set.round=1;                    % rounding for _ digit after semicolon
% Set properties for 1D fitting
set.fit_polynome1D='poly6';      % Fitting type for 1D: Polynome 6th order
set.fit_centscale1D='off';       % Fitting includig "Centering and Scaling"
% Set properties for 2D fitting
set.fit_polynome2D='poly55';     % Fitting type for 1D: Polynome 6th order
set.fit_centscale2D='off';       % Fitting includig "Centering and Scaling"

set.fit_intervallsection=1;      % Fitting in intervall between [-a,a]
set.magneticAngleTolerance=0.01; % To find magnetic moment
set.dTolerance=1; % To find distance d
% Filename (default)
set.filename='RingMagnet_Rough5_70.txt'; 

% Process modified settings of simulation
set=processSimuProperties(set);