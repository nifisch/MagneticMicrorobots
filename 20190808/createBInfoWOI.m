%% createBInfoWOI
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190726
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Creates ideal Binfo
%-------------------------------------------------------------------------
function [BinfoWOI]=createBInfoWOI(set)

BinfoWOI.Interval_x=set.workspaceScenarioLayout(1):set.interpolStep:...
    set.workspaceScenarioLayout(2);
BinfoWOI.Interval_y=set.workspaceScenarioLayout(3):set.interpolStep:...
    set.workspaceScenarioLayout(4);
BinfoWOI.Interval_z=set.workspaceScenarioLayout(5):set.interpolStep:...
    set.workspaceScenarioLayout(6);

BinfoWOI.Intmin_x=set.workspaceScenarioLayout(1);
BinfoWOI.Intmin_y=set.workspaceScenarioLayout(3);
BinfoWOI.Intmin_z=set.workspaceScenarioLayout(5);

BinfoWOI.Intmax_x=set.workspaceScenarioLayout(2);
BinfoWOI.Intmax_y=set.workspaceScenarioLayout(4);
BinfoWOI.Intmax_z=set.workspaceScenarioLayout(6);

BinfoWOI.nbpoints_x=length(BinfoWOI.Interval_x);
BinfoWOI.nbpoints_y=length(BinfoWOI.Interval_y);
BinfoWOI.nbpoints_z=length(BinfoWOI.Interval_z);

BinfoWOI.stepsize_x=set.interpolStep;
BinfoWOI.stepsize_y=set.interpolStep;
BinfoWOI.stepsize_z=set.interpolStep;