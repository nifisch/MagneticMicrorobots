%% addMagnet
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190805
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER 
% Used by:      createScenario.m
% Description:  Adds 1 Magnet with specific position and orientation
%-------------------------------------------------------------------------
% function [BNew,setNew]=addMagnet(setOld,B_1Magnet,CV,EA)
function [BNew]=addMagnet(set,Binfo,BinfoWOI,B_1Magnet,CV,EA)

% Change position and orientation of Magnet
b_list=moveOrientMagnet(Binfo,B_1Magnet,CV,EA);
clear B_1Magnet CV EA 

% % Observe vectorfield

% Create table of Vector field data
% b_table = table(b_list(:,1),b_list(:,2),b_list(:,3),b_list(:,4),...
%   b_list(:,5),b_list(:,6), 'VariableNames', {'x','y','z','bx','by','bz'});
% [B_1Magnet,Binfo]=getB_vectorfield(b_table);
% visualiseBfield(B_1Magnet,Binfo)


% Create vector field list   
% Round to avoid numerical problems (only spatial columns)
if set.round==0
    b_list(:,1:3)=round(b_list(:,1:3)); % Round to integer
else
    b_list(:,1:3)=round(b_list(:,1:3),set.round); % Round acc. to set
end

% Create table of Vector field data
b_table = table(b_list(:,1),b_list(:,2),b_list(:,3),b_list(:,4),...
  b_list(:,5),b_list(:,6), 'VariableNames', {'x','y','z','bx','by','bz'});
clear b_list

% Consider only data within observed space, "trimm edges" 
% [b_table]=trimTableEdges(setOld,b_table);
[b_table]=trimTableEdgesWOI(set,b_table);

% Get B vector field within Workspace of Interest
% [BNew,Binfo]=getB_vectorfieldWOI(b_table);
[BNew,Binfo]=getBvectorfield(b_table);
clear b_table
% visualiseBfield(BNew,Binfo)


%% Interpolate Bnew in 3D within workspace of interest
[BNew]=interpolateWOI(BNew,Binfo,BinfoWOI);
% visualiseBfield(BNew,BinfoWOI)