%% processSimuProperties
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      setSimuProperties.m
% Description:  Process modified settings of simulation
%-------------------------------------------------------------------------
function [set]=processSimuProperties(set)

%% ii) Further Properties (default)

set.workspaceScenarioLayout=set.workspace;

if strcmp(set.scenarioDescription,'Scenario Standard')==1
	% Magnets and description
	%           |----------------------------------------------------------|
	%           |    position    |  euler-angles (z,y,x)   | dimensions    |
	%           |   x   y   z    |  yaw     pitch  roll]   | w   l   h     |  
	%           |----------------------------------------------------------|
	set.magnets=[   0 0 30        0  0   0      30  10  10 ];  ...
	%           |----------------------------------------------------------|
	
elseif strcmp(set.scenarioDescription,'Scenario 01')==1
% Magnets and description
%           |----------------------------------------------------------|
%           |    position    |  euler-angles (z,y,x)   | dimensions    |
%           |   x   y   z    |  yaw     pitch  roll]   | w   l   h     |  
%           |----------------------------------------------------------|
set.magnets=[   0 0 30        0  0   0      30  10  10 ;  ...
%           |----------------------------------------------------------|
                0  0   -30     90     0       0       30  10  10  ];...
% %         |----------------------------------------------------------|
%                 0   -15 15      0       0       0          30  10  10;...
% %         |----------------------------------------------------------|
%                  0 15   15      0       0       0          30  10  10];
%           |----------------------------------------------------------|  
end

% Entity of magnets
s=size(set.magnets);            set.amountMagnets=s(1);

% Modify workspace, if magnets limit it in all three dimensions
% set=modifyWorkspace(set,'x');
% set=modifyWorkspace(set,'y');
set=modifyWorkspace(set,'z');

% For scenarios, where magnets are located only in positive z
if set.workspace(5)>0
    set.workspace(5)=0;
end

if set.workspaceScenarioLayout(5)>0
    set.workspaceScenarioLayout(5)=0;
end

% Create equidistant workspace for scenario layout
Min=min(set.workspaceScenarioLayout(1:4));
Max=max(set.workspaceScenarioLayout(1:4));

set.workspaceScenarioLayout(1)=Min;
set.workspaceScenarioLayout(2)=Max;
set.workspaceScenarioLayout(3)=Min;
set.workspaceScenarioLayout(4)=Max;

% Set altitude steps based on workspace
set.zPlatform=set.workspaceScenarioLayout(5):set.zPlatformStep:...
    set.workspaceScenarioLayout(6);

% Modify axis in getVisual
horizontal=sort([set.zPlatform(1) set.zPlatform(end)]);
vertical=[-set.a set.a];
set.axisGetvisual=[horizontal vertical];

if set.MR=='alpha'
    % Modify angles to allows loop processing
    set.alphaR=deg2rad(set.alpha); % Transfer to unit rad
    temp_a=unique(abs(set.alphaR)); set.alphaR_half=temp_a(find(temp_a));
    set.MR_half=set.alphaR_half;
elseif set.MR=='d'
    set.MR_half=unique(abs(set.d));
end

% Save set.magnets with angles for getvisual
set.magnetsVisual=set.magnets;

% Use rad instead of angles for magnet description
for i=1:set.amountMagnets
    set.magnets(i,4)=deg2rad(set.magnets(i,4));
    set.magnets(i,5)=deg2rad(set.magnets(i,5));
    set.magnets(i,6)=deg2rad(set.magnets(i,6));
end

% Simulation Flavour
if strcmp(set.simulationFlavour,'quick')==1
    set.filename='RingMagnet_Rough5_70.txt'; 
    set.zPlatformStep=5;
    set.interpolStep=single(5);
elseif strcmp(set.simulationFlavour,'slow')==1
    set.filename='RingMagnet_Rough2_70.txt'; 
    set.zPlatformStep=2;
    set.interpolStep=single(2);
end