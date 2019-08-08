%% createPoe
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190801
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Creates structs for poe based on two inputs 1D
%-------------------------------------------------------------------------
function [poe]=createPoe(set, input1, input2,alt)

% Set struct x_EQ3 for solution arrays (d or alpha * alt * x_equilibria)
poe.xpos=nan(length(input1),length(alt),set.peq);
poe.xcenter=nan(1,length(alt),set.peq);
poe.xneg=nan(length(input1),length(alt),set.peq);

% Set struct y_EQ3 for solution arrays (d or alpha * alt * x_equilibria)
poe.ypos=nan(length(input2),length(alt),set.peq);
poe.ycenter=nan(1,length(alt),set.peq);
poe.yneg=nan(length(input2),length(alt),set.peq);