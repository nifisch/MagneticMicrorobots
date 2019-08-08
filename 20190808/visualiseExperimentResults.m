%% visualiseExperimentResults
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      visualiseExperiments.m
% Description:  Visualises experimental results for comparison with simu.
%-------------------------------------------------------------------------
function visualiseExperimentResults(set,M,file,expnb)

%% SETUP
% Import points of equilibrium as list from *.txt file
exp=impExp(fullfile(pwd,'Experimental_data',file));

% Colour of lines in plot
 col=['b','r','m','g','b','r','m','g'];

% Figure descriptions
figure('Name',['Points of Equilibrium (2D) - Experiment',num2str(expnb)])

if MRprop=='d'
	half=set.MR_half;
	half_vis=half;
elseif MRprop=='alpha'
	half=set.MR_half;
	half_vis=rad2deg(set.alphaR_half);
end

  % Define whether used for Equilibrium or Equilibrium MultiScen
if strcmp(ztype,'zMA')==1
	alt=set.zMA;    % Equilibrium MultiScen
elseif strcmp(ztype,'zPlatform')==1
	alt=set.zPlatform;     % Equilibrium
end

%% Prepare plot/scatter
for i_input=1:length(half)

	expi=exp; % Create temporary table with results

	d=half(i_input);

	% Delete edges so only wanted d remains
	toDelete =expi.d ~= d; % in x
	expi(toDelete ,:) = [];

	i_Md=find(abs(M.d_inx-d)<0.1);
	alpha=M.alpha(i_Md);

	 i_inv=length(half)-i_input+1;

	% Positive inputs
	pos=scatter3(expi.x,expi.y,expi.alt_platform,'MarkerEdgeColor',col(i_inv));
	hold on
	% Prepare legend (pos)
	legendpos=['d=',num2str(d),' mm'];

	% Negative inputs
	% Notice: Reverse for symetry
	neg=scatter3(-1*expi.x,-1*expi.y,expi.alt_platform,'MarkerFaceColor',col(i_input));
	hold on
	% Prepare legend (neg)
	legendneg=['d=-',num2str(d),' mm']; 
end

d=0;

% Delete edges so only wanted d remains
toDelete =expi.d ~= d; % in x
expi(toDelete ,:) = [];

i_Md=find(abs(M.d_inx-d)<0.1);
alpha=M.alpha(i_Md);

i_inv=length(half)-i_input+1;
% Input at center position
cent=scatter3(-1*expi.x,-1*expi.y,expi.[,'MarkerFaceColor',col(i_input));
hold on
% Prepare legend (neg)
legendcent=['d=',num2str(d),' mm'];

%% Form complete plot
compplot=[pos,cent,neg];
complotlegend=[legendpos,legendcent,legendneg];

legend(compplot(1,:),complotlegend)
title(['Equilibrium in x-y-plane | Experiment ',num2str(expnb),' | MB=',num2str(exp.MB(1))])

xlabel(['Distance from magnetic centre (x-axis) in mm'])
ylabel(['Distance from magnetic centre (y-axis) in mm'])
zlabel(['Altitude of platform (z-axis) in mm'])