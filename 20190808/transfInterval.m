%% transfInterval
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190603
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER  
% Used by:      setBfileProperties.m,MoveOrientMagnet.m
% Description:  Transforms intervalls to integer or double values
%-------------------------------------------------------------------------
function [set]=transfInterval(set,order)

if order == 'double2int' % Converts intervalls from double to integer
%     set.Intervall_x=int16(set.Interval_x);
%     set.Intervall_y=int16(set.Interval_y);
%     set.Intervall_z=int16(set.Interval_z);
elseif order == 'int2double' % Converts intervalls from integer to double
    set.Intervall_x=double(set.Interval_x);
    set.Intervall_y=double(set.Interval_y);
    set.Intervall_z=double(set.Interval_z);   
end