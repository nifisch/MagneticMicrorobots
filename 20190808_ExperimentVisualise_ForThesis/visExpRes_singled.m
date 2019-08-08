%% visExpRes_singled
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      visualiseExperiments.m
% Description:  Visualises experimental results for comparison with simu.
%-------------------------------------------------------------------------
function [sc,l]=visExpRes_singled(set,d,color,file,exnb)

if set.visExperimentresult_entity~=1 % Experimental results in 1 plot
    figure('Name',['Points of Equilibrium (2D) - Experiment',num2str(exnb)])
else
    
    if exnb == 1    % Experiment 1 is visualised

        % Import points of equilibrium as list from *.txt file
        exp=impExp(fullfile(pwd,'Experimental_data',file));

        % Delete edges so only wanted d remains
        toDelete =exp.d ~= d; % in x
        exp(toDelete ,:) = [];

        sc.pos=scatter3(exp.x,exp.y,exp.alt_platform,'Marker','*','MarkerEdgeColor',color);
        hold on
        sc.neg=scatter3(-1*exp.x,-1*exp.y,exp.alt_platform,'MarkerFaceColor',color);
        hold on

        % axis(set.axisGetvisual)

    elseif exnb ==2 % Experiment 2 is visualised
        % Import points of equilibrium as list from *.txt file
        exp=impExp2(fullfile(pwd,'Experimental_data',file));

        % Delete edges so only wanted d remains
        toDelete =exp.d ~= d; % in x
        exp(toDelete ,:) = [];

        sc.pos=scatter3(exp.x2,exp.y2,exp.alt_platform,'Marker','*','MarkerEdgeColor',color);
        hold on
        sc.neg=scatter3(exp.x1,exp.y1,exp.alt_platform,'MarkerFaceColor',color);
        hold on
    end
end

if set.visExperimentresult_entity==1 % Save legend for later
    l.pos=['d=',num2str(d),' mm']; l.neg=['d=-',num2str(d),' mm'];
%     'Orientation','vertical','Location','southoutside')

else % Show legend immediately
   legend(['d=',num2str(d),' mm'],['d=-',num2str(d),' mm'],...
        'Orientation','vertical','Location','southeast')
%     'Orientation','vertical','Location','southoutside')  
    l=nan;
end

title(['Equilibrium in x-y-plane | Experiment ',num2str(exnb)...
    ,' | MB=',num2str(exp.MB(1))])

xlabel('Distance from magnetic centre (x-axis) in mm')
ylabel('Distance from magnetic centre (y-axis) in mm')
zlabel('Altitude of platform (z-axis) in mm')
hold on
end