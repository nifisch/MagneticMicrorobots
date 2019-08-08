%% visualiseExtremum2D
%---------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium_d.m (main)
% Description:  Visualises Extremum procedure
%--------------------------------------------------
function visualiseExtremum2D(set,X,Y,f,i_zPlatform,i_sign,i_MR,zmax,imax,zmin,imin)

zPlatform=set.zPlatform(i_zPlatform);

% Create surface plot
figure('Name',['Altitude: ',num2str(zPlatform)])
surf(X,Y,f)

hold on

% Plot Extrema points in surface figure
plot3(X(imax),Y(imax),zmax,'bo',X(imin),Y(imin),zmin,'ro') %MIN

      for i = 1:length(zmax)
       text(X(imax(i)),Y(imax(i)),zmax(i),['  ' num2str(zmax(i))]) %MAX
      end

%       for i = 1:length(zmin)
%        text(X(imin(i)),Y(imin(i)),zmin(i),['  ' num2str(zmin(i))])
%       end

hold off 

xlabel(['Distance from magnetic centre (x-axis) in mm'])
ylabel(['Distance from magnetic centre (y-axis) in mm'])

% % Display Magnet information
% for i=1:set.amountMagnets   
%     u=(0.5-i*0.05);
%     dimMagnet = [.2 u .3 .3];
%     strMagnet=['Magnet ',num2str(i),'| ',num2str(set.magnetsVisual(1,:))];
%     annotation('textbox',dimMagnet,'String',strMagnet,'FitBoxToText','on');
% end

% % Display additional information concerning Workspace
% dimWorkspace = [.2 .7 .3 .3];
% strWorkspace=['WorkspaceScenario: ',num2str(set.workspaceScenarioLayout)];
% annotation('textbox',dimWorkspace,'String',strWorkspace,'FitBoxToText','on');

% % Display additional information concerning Altitude
% dimAlt = [0.2 .65 .3 .3];
% strAlt=['Altitude: ',num2str(zPlatform),' mm'];
% annotation('textbox',dimAlt,'String',strAlt,'FitBoxToText','on');
% 
% % Display additional information concerning angle alpha
% dimAng = [0.2 .6 .3 .3];
% 
% if set.MR=='alpha'
%     ang=rad2deg(set.MR_half(i_MR));
% 
%     if i_sign == 1
%         signAng=' ';
%     elseif i_sign ==2 
%         signAng='-';
%     elseif i_sign ==3
%         signAng=' ';
%         ang=0;
%     end
% 
%     strAng=['Angle alpha: ',signAng,num2str(ang),'°'];
    % strAng=['Angle alpha: ',num2str(set.alpha(i_alpha)),'°'];
%     annotation('textbox',dimAng,'String',strAng,'FitBoxToText','on');
end