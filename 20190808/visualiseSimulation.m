%% visualiseSimulation
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium_d.m (main)
% Description:  Creates plots for the points of equilibra in 1-D depending
%               on distance to center and magnet's altitude; 
%-------------------------------------------------------------------------
function visualiseSimulation(set,poe_1D,poe_2D,ztype)
if set.MR=='alpha'
visualise(set,poe_1D,'x','Points of Equilibrium in x','alpha','°',ztype);  
% visualise(set,poe_1D,'y','Points of Equilibrium in y','alpha','°',ztype);
visualise2D(set,poe_2D,'Points of Equilibrium (2D)','alpha','°',ztype);
elseif set.MR=='d'
visualise(set,poe_1D,'x','Points of Equilibrium in x','d','mm',ztype);  
% visualise(set,poe_1D,'y','Points of Equilibrium in y','d','mm',ztype);
visualise2D(set,poe_2D,'Points of Equilibrium (2D)','d','mm',ztype);
end