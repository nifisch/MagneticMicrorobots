%% trimTableEdges
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190603
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER  
% Used by:      addMagnet.m
% Description:  Consider only data within observed space, "trimm edges" 
%-------------------------------------------------------------------------
function [b_table_trimmed]=trimTableEdges(setOld,b_table_trimmed)
% Delete edges
toDelete_x_pos =b_table_trimmed.x < min(setOld.Interval_x); % in x
b_table_trimmed(toDelete_x_pos ,:) = [];

toDelete_x_neg =b_table_trimmed.x > max(setOld.Interval_x);
b_table_trimmed(toDelete_x_neg ,:) = [];

toDelete_y_pos =b_table_trimmed.y < min(setOld.Interval_y); % in y
b_table_trimmed(toDelete_y_pos ,:) = [];

toDelete_y_neg =b_table_trimmed.y > max(setOld.Interval_y);
b_table_trimmed(toDelete_y_neg ,:) = [];

toDelete_z_pos =b_table_trimmed.z < min(setOld.Interval_z); % in z
b_table_trimmed(toDelete_z_pos ,:) = [];

toDelete_z_neg =b_table_trimmed.z > max(setOld.Interval_z);
b_table_trimmed(toDelete_z_neg ,:) = [];