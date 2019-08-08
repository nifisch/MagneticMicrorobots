%% visualise
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      visualiseSimulation.m
% Description:  Creates plots for the points of equilibra in 1-D depending
%               on distance to center and magnet's altitude; 
%-------------------------------------------------------------------------
function visualise(set,poe,input,expl,MRprop,unit,ztype)

if set.dimension==1
    %% SETUP
    % Colour of lines in plot
     col=['b','r','g','m','b','r','g','m'];

    heading=[expl,' | ',set.scenarioDescription];

    % Figure descriptions
    figtitle=['Equilibrium along ',input,'-axis: ',heading];
    figure('Name',figtitle)

    % Adapt getVisual_eq to input
    formEQ3pos=[input,'pos'];
    formEQ3center=[input,'center'];
    formEQ3neg=[input,'neg'];

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

    
    %% Prepare plot
    for i=1:length(half)

         i_inv=length(half)-i+1;

        % Positive inputs 
        for i_peq=1:set.peq
            pos(i_peq,i)=plot(alt,...
                poe.(formEQ3pos)(i_inv,:,i_peq),'Color',col(i_inv));
            hold on
        end

        % Save distances to prepare legend (pos)
        legendpos(i)=string([MRprop,'=',num2str(half_vis(i_inv)),unit]);

        % Negative inputs
        % Notice: Reverse for symetry
        for i_peq=1:set.peq
            neg(i_peq,i)=plot(alt,...
                poe.(formEQ3neg)(i,:,i_peq),...
                'Color',col(i),'LineStyle','--','Linewidth',2);
            hold on
        end   

        % Save distances to prepare legend (neg)
        legendneg(i)=string([MRprop,'=-',num2str(half_vis(i)),unit]);
    end 

    % Input at center position
     % For all points of equilibria for alpha=0
    for i_peq=1:set.peq
        cent(i_peq,1)=plot(alt,poe.(formEQ3center)(1,:,i_peq),'Color',...
            'k','LineStyle',':','Linewidth',2);
    hold on
    end

    legendcent=[MRprop,'=0',unit];

    %% Form complete plot
    compplot=[pos,cent,neg];
    complotlegend=[legendpos,legendcent,legendneg];

    legend(compplot(1,:),complotlegend)
    title(['Equilibrium along ',input,'-axis | ',set.scenarioDescription])
    xlabel('Altitude of platform (z-axis) in mm')
    ylabel(['Distance from magnetic centre (',input,'-axis) in mm'])
    axis(set.axisGetvisual)

%     % Display Magnet information
%     text(double(min(alt)+1),double(set.a-4),num2str(set.magnetsVisual))
    grid on
end