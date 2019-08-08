%% getBvectorfieldWOI - Workspace of Interest
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190805
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      addMagnet.m
% Description:  Get B vector field within Workspace of Interest
%-------------------------------------------------------------------------
function [B,Binfo]=getBvectorfieldWOI(b_table)

[Binfo]=getBFileInfo(b_table);

% Go through all datapoints in b_field file
for i=1:height(b_table)
% Find indicies of xyzInterval to determin coordinates in array
xi=find(abs(Binfo.Interval_x-b_table.x(i))<Binfo.stepsize_x/2);
yi=find(abs(Binfo.Interval_y-b_table.y(i))<Binfo.stepsize_y/2);
zi=find(abs(Binfo.Interval_z-b_table.z(i))<Binfo.stepsize_z/2);

% xi=find(abs(Binfo.Interval_x-b_table.x(i))<0.1);
% yi=find(abs(Binfo.Interval_y-b_table.y(i))<0.1);
% zi=find(abs(Binfo.Interval_z-b_table.z(i))<0.1);

    if isempty(xi)==1 || isempty(yi)==1 || isempty(zi)
  disp('getB_vectorfieldWOI(b_table): xi or yi or zi - find is empty');
    B.empty=[];
    else

        % Create Bx, By, Bz matrices for every point in the array
        B.x(xi,yi,zi)=single(b_table.bx(i));
        B.y(xi,yi,zi)=single(b_table.by(i));
        B.z(xi,yi,zi)=single(b_table.bz(i));
    end
end