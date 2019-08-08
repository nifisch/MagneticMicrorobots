%% getBvectorfield
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190805
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Get B vector field
%-------------------------------------------------------------------------
function [B,Binfo]=getBvectorfield(b_table)

[Binfo]=getBFileInfo(b_table);

% Go through all datapoints in b_field file
for i=1:height(b_table)
% Find indicies of xyzInterval to determin coordinates in array
xi=find(abs(Binfo.Interval_x-b_table.x(i))<Binfo.stepsize_x/2);
yi=find(abs(Binfo.Interval_y-b_table.y(i))<Binfo.stepsize_y/2);
zi=find(abs(Binfo.Interval_z-b_table.z(i))<Binfo.stepsize_z/2);

% Create Bx, By, Bz matrices for every point in the array
B.x(xi,yi,zi)=single(b_table.bx(i));
B.y(xi,yi,zi)=single(b_table.by(i));
B.z(xi,yi,zi)=single(b_table.bz(i));
end