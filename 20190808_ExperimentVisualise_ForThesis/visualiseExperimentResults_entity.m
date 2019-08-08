%% visualiseExperimentResults_entity
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190805
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      visualiseExperiments.m
% Description:  Visualises experimental results all together
%-------------------------------------------------------------------------
function visualiseExperimentResults_entity(color,file,expnb)


if expnb == 1    % Experiment 1 is visualised
    
    % Import points of equilibrium as list from *.txt file
    exp=impExp(fullfile(pwd,'Experimental_data',file));

    % Delete edges so only wanted d remains
    toDelete =exp.d ~= d; % in x
    exp(toDelete ,:) = [];
    
    scatter3...
        (exp.x,exp.y,exp.alt_platform,'Marker','*','MarkerEdgeColor',color)
    hold on
    scatter3...
        (-1*exp.x,-1*exp.y,exp.alt_platform,'MarkerFaceColor',color)
    hold on

    % axis(set.axisGetvisual)
    
elseif expnb ==2 % Experiment 2 is visualised
    % Import points of equilibrium as list from *.txt file
    exp=impExp2(fullfile(pwd,'Experimental_data',file));
    
    % Delete edges so only wanted d remains
    toDelete =exp.d ~= d; % in x
    exp(toDelete ,:) = [];
    
    scatter3...
      (exp.x2,exp.y2,exp.alt_platform,'Marker','*','MarkerEdgeColor',color)
    hold on
    scatter3...
      (exp.x1,exp.y1,exp.alt_platform,'MarkerFaceColor',color)
    hold on
end

legend(['d=',num2str(d),' mm'],['d=-',num2str(d),' mm'],...
        'Orientation','vertical','Location','southeast')
%     'Orientation','vertical','Location','southoutside')
title(['Equilibrium in x-y-plane | Experiment ',num2str(expnb)...
    ,' | MB=',num2str(exp.MB(1))])

xlabel(['Distance from magnetic centre (x-axis) in mm'])
ylabel(['Distance from magnetic centre (y-axis) in mm'])
zlabel(['Altitude of platform (z-axis) in mm'])
