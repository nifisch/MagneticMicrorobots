%% trimTableEdgesWOI - Workspace of Interest
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190605
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER  
% Used by:      addMagnet.m
% Description:  Consider only data within WOI, "trimm edges" 
%-------------------------------------------------------------------------
function [b_table_trimmed]=trimTableEdgesWOI(set,b_table_trimmed)
% Delete edges
toDelete_x_pos =b_table_trimmed.x < set.workspace(1); % in x
b_table_trimmed(toDelete_x_pos ,:) = [];

toDelete_x_neg =b_table_trimmed.x > set.workspace(2);
b_table_trimmed(toDelete_x_neg ,:) = [];

toDelete_y_pos =b_table_trimmed.y < set.workspace(3); % in y
b_table_trimmed(toDelete_y_pos ,:) = [];

toDelete_y_neg =b_table_trimmed.y > set.workspace(4);
b_table_trimmed(toDelete_y_neg ,:) = [];

toDelete_z_pos =b_table_trimmed.z < set.workspace(5); % in z
b_table_trimmed(toDelete_z_pos ,:) = [];

toDelete_z_neg =b_table_trimmed.z > set.workspace(6);
b_table_trimmed(toDelete_z_neg ,:) = [];