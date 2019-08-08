%% getBFileInfo
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190605
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getBvectorfield.m
% Description:  Set properties in accordance with the loaded file
%-------------------------------------------------------------------------
function [Binfo]=getBFileInfo(b_field)

% Intervalls o data points
Binfo.Interval_x=single(unique(b_field.x));
Binfo.Interval_y=single(unique(b_field.y));
Binfo.Interval_z=single(unique(b_field.z));

% Minimum
Binfo.Intmin_x=min(Binfo.Interval_x);
Binfo.Intmin_y=min(Binfo.Interval_y);
Binfo.Intmin_z=min(Binfo.Interval_z);
% Maximum
Binfo.Intmax_x=max(Binfo.Interval_x);
Binfo.Intmax_y=max(Binfo.Interval_y);
Binfo.Intmax_z=max(Binfo.Interval_z);

% Number of data points
Binfo.nbpoints_x=length(Binfo.Interval_x);% in x direction
Binfo.nbpoints_y=length(Binfo.Interval_y);% in y direction
Binfo.nbpoints_z=length(Binfo.Interval_z);% in z direction 

% Stepsize
Binfo.stepsize_x=mean(gradient(Binfo.Interval_x)); % in x direction
Binfo.stepsize_y=mean(gradient(Binfo.Interval_y));% in y direction
Binfo.stepsize_z=mean(gradient(Binfo.Interval_z)); % in z direction