%% visualiseBfield
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190724
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      createScenario.m
% Description:  Visualise Magnetic field within Scenario Layout
%-------------------------------------------------------------------------
function visualiseBfield(Bmatfile,Binfo)
%% Visualise symbolically the B-field vector at magnet's center
[Y,X,Z]=meshgrid(...
    Binfo.Interval_y,...
    Binfo.Interval_x,...
    Binfo.Interval_z);

quiver3(X,Y,Z,Bmatfile.x,Bmatfile.y,Bmatfile.z,1,'Color','b')

title('Scenario Layout')
zlabel('z-axis in mm')
xlabel('x-axis in mm')
ylabel('y-axis in mm')
grid on
%% Visualise entity of superpositioned B fields (memory overload)
% [Y,X,Z]=meshgrid(...
%     BinfoWOI.Interval_y,...
%     BinfoWOI.Interval_x,...
%     BinfoWOI.Interval_z);
% 
% quiver3(X,Y,Z,BSuperpos.x,BSuperpos.y,BSuperpos.z,3,'Color','b')