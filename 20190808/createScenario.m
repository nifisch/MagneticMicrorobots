%% createScenario
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190708
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Creates magnetic scenario
%-------------------------------------------------------------------------
% function [BSuperpos,setNew]=createScenario(B_1Magnet,set)
function [Bmatfile]=createScenario(B_1Magnet,set,Binfo,BinfoWOI)

% Gets initial Array with zeros for entire WOI
ArrayInit=single(zeros(...
       BinfoWOI.nbpoints_x,...
       BinfoWOI.nbpoints_y,...
       BinfoWOI.nbpoints_z));

% Prepare for first loop turn
% BinfoOld=Binfo;
BOld.x=ArrayInit; BOld.y=ArrayInit; BOld.z=ArrayInit;
clear ArrayInit

%% Create figure and plot for Scenario Layout
if set.visBvecfield==1  || set.visMagnets==1    
    figure('NAME','Scenario Description')
    plot3(Binfo.Interval_x,Binfo.Interval_y,nan(Binfo.nbpoints_z))
    axis(set.workspaceScenarioLayout)
end

% Create, superposition, visualize B-fields of all magnets
for i=1:set.amountMagnets
        
       % SL    - [X;Y;Z] Length of Cuboid Side (SL - SideLength)
       SL=[set.magnets(i,7);set.magnets(i,8);set.magnets(i,9)];
        
       % CV    - [X;Y;Z] Center of volume
       CV=[set.magnets(i,1);set.magnets(i,2);set.magnets(i,3)];
    
       % EA    - [Yaw(Z-axis);Pitch(y-axis);
       %  Roll(x-axis)] Euler/Rotation angles [radians]
       EA=[set.magnets(i,4);set.magnets(i,5);set.magnets(i,6)];
    
       % Create Magnet and B-Field
       [BNew]=addMagnet(set,Binfo,BinfoWOI,B_1Magnet,CV,EA);  
       
       % Superposition x-components
       BSuperpos.x=BNew.x+BOld.x;  BOld.x=BSuperpos.x;
       % Superposition y-components
       BSuperpos.y=BNew.y+BOld.y;  BOld.y=BSuperpos.y;
       % Superposition z-components
       BSuperpos.z=BNew.z+BOld.z;  BOld.z=BSuperpos.z;  
       
       clear BNew
 
    if set.visMagnets==1  
           % Visualise magnets
           [~, ~, ~] = DrawCuboid(SL,CV,EA);
           grid on
           hold on
    end

end

save('Bsuperpos.mat','-struct','BSuperpos','-v7.3')
Bmatfile=matfile('Bsuperpos.mat');
clear  BOld B_1Magnet

if set.visBvecfield==1  
    % Visualise Magnetic field within Scenario Layout
    visualiseBfield(Bmatfile,BinfoWOI);
end
title('Scenario Layout')
zlabel('z-axis in mm')
xlabel('x-axis in mm')
ylabel('y-axis in mm')
grid on
hold on
clear BSuperpos
clear  X Y Z