%% updateBFileProperties
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190603
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      trimArrayEdges.m
% Description:  Update chosen settings based on set.intervall x,y,z
%-------------------------------------------------------------------------
function [set]=updateBFileProperties(set)

% Maximum, Minimum
set.Intmax_x=max(set.Interval_x);
set.Intmax_y=max(set.Interval_y);
set.Intmax_z=max(set.Interval_z);
set.Intmin_x=min(set.Interval_x);
set.Intmin_y=min(set.Interval_y);
set.Intmin_z=min(set.Interval_z);
% Number of data points
set.nbpoints_x=length(set.Interval_x);% in x direction
set.nbpoints_y=length(set.Interval_y);% in y direction
set.nbpoints_z=length(set.Interval_z);% in z direction 

if isinteger(set.Interval_x)== 1
% Stepsize (only for integer Intervalls)
set.stepsize_x=set.Interval_x(2)-set.Interval_x(1); % in x direction
set.stepsize_y=set.Interval_y(2)-set.Interval_y(1); % in x direction
set.stepsize_z=set.Interval_z(2)-set.Interval_z(1); % in x direction
else
% Stepsize (only for double Intervalls)
set.stepsize_x=mean(gradient(set.Interval_x)); % in x direction
set.stepsize_y=mean(gradient(set.Interval_y));% in y direction
set.stepsize_z=mean(gradient(set.Interval_z)); % in z direction
end