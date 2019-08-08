%% getEqu2D_num
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getEqu2D.m
% Description:  Get poe in 2D - numerically
%-------------------------------------------------------------------------
function [poe]=getEqu2D_num(BinfoWOI,f,set,X,Y,i_zPlatform,i_sign,i_alpha)  
        
% Find extrema points
[fmax,imax,fmin,imin] = extrema2(f);

if set.visSurfaceplotExtrema==1
% Visualises Extremum procedure
visualiseExtremum2D...
    (set,X,Y,f,i_zPlatform,i_sign,i_alpha,fmax,imax,fmin,imin);
end

% Create tablelike array  (magnitude of maximum | x_eq | y _eq)
for i = 1:length(fmax)
      [i_x,i_y]=ind2sub(size(f),imax(i));% Convert linear->matrix index
      poe(i,:)=[BinfoWOI.Interval_x(i_x),...
          BinfoWOI.Interval_y(i_y),fmax(i)];
end   