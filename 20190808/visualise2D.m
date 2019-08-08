%% visualise2D
%---------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium_d.m (main)
% Description:  Creates plots for the points of equilibra in 2D
%--------------------------------------------------
function visualise2D(set,EQ3_2D,expl,MRprop,unit,ztype)

if set.dimension==2
    %% SETUP
    % Colour of lines in plot
     col=['b','r','g','b','r','g','m','g'];

    heading=[expl,' | ',set.scenarioDescription];

    % Figure descriptions
    figtitle=heading;
    figure('Name',figtitle)

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
              pos(i_peq,i)=plot3(...
                EQ3_2D.xpos(i_inv,:,i_peq),...
                EQ3_2D.ypos(i_inv,:,i_peq),...
                alt,...
                'Color',col(i_inv));
            hold on
        end

        % Save distances to prepare legend (pos)
        legendpos(i)=string([MRprop,'=',num2str(half_vis(i_inv)),unit]);

        % Negative inputs
        % Notice: Reverse for symetry
        for i_peq=1:set.peq
             neg(i_peq,i)=plot3(...
                 EQ3_2D.xneg(i,:,i_peq),...
                 EQ3_2D.yneg(i,:,i_peq),...
                 alt,...
                'Color',col(i),'LineStyle','--','Linewidth',2);
            hold on
        end   

        % Save distances to prepare legend (neg)
        legendneg(i)=string([MRprop,'=-',num2str(half_vis(i)),unit]);
    end 

    % Input at center position
     % For all points of equilibria for alpha=0
    for i_peq=1:set.peq
         cent(i_peq,1)=plot3(...
             EQ3_2D.xcenter(1,:,i_peq),...
             EQ3_2D.ycenter(1,:,i_peq),...
             alt,'Color',...
            'k','LineStyle',':','Linewidth',2);
    hold on
    end

    legendcent=[MRprop,'=0',unit];

    %% Form complete plot
    compplot=[pos,cent,neg];
    complotlegend=[legendpos,legendcent,legendneg];

    legend(compplot(1,:),complotlegend)
    title(['Equilibrium in x-y-plane | ',set.scenarioDescription])

    xlabel(['Distance from magnetic centre (x-axis) in mm'])
    ylabel(['Distance from magnetic centre (y-axis) in mm'])
    zlabel(['Altitude of platform (z-axis) in mm'])

    axis(set.axisGetvisual)

%     % Display Magnet information
%     for i=1:set.amountMagnets   
%         u=(0.6-i*0.05);
%         dimMagnet = [.2 u .3 .3];
%         strMagnet=['Magnet ',num2str(i),'|',num2str(set.magnetsVisual(i,:))];
%         annotation('textbox',dimMagnet,'String',strMagnet,'FitBoxToText','on');
%     end

%     % Display additional information
%     dimWorkspace = [.2 .6 .3 .3];
%     strWorkspace=['WorkspaceScenario: ',num2str(set.workspaceScenarioLayout)];
%     annotation('textbox',dimWorkspace,'String',strWorkspace,'FitBoxToText','on');

    % Display Magnet information
    % dimMagnet = [.2 .6 .3 .3];
    % strMagnet=['Magnet: ',num2str(set.magnetsVisual)];

    % % Display Magnet information
    % text(double(min(alt)+1),double(set.a-4),num2str(set.magnetsVisual))
    % 
    % % Display additional information
    % dimWorkspace = [.2 .05 .3 .3];
    % strWorkspace=['WorkspaceScenario: ',num2str(set.workspaceScenarioLayout)];
    % % annotation(double(min(alt)+1),double(set.a-4),...
    % annotation('textbox',dimMagnet,'String',strMagnet,'FitBoxToText','on');
    % annotation('textbox',dimWorkspace,'String',strWorkspace,'FitBoxToText','on');
    grid on
end