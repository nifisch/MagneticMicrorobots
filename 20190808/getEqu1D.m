%% getEqu1D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Get poe in 1D
%-------------------------------------------------------------------------
function [poe1D]=getEqu1D(set,poe1D,i_z,i_sign,i_MR,Bmatfile,BinfoWOI,m)

if set.dimension==1
    
    i_zPlatform=i_z(1);
    i_zB=i_z(2);

    %% For x   
    % Get B vector components along x0 (line) for fixed y0 and z0
    [B1D_x]=getB1D('x',0,i_zB,Bmatfile,BinfoWOI);
    % Get f1D_x of that line 
    f1D_x=m.x*B1D_x.x+m.z*B1D_x.z;  % y-component neglected
%     f1D_x=m.x*B1D_x.x+m.y*B1D_x.y+m.z*B1D_x.z; 

    if set.polynomial==1 % Polynomial approach
      % local extrema in x (with y=0)
      [poe1D]=getEqu1D_poly('x',set,f1D_x,BinfoWOI.Interval_x,...
      poe1D,i_MR,i_zPlatform, i_sign);
    else                 % Numerical approach
        [poe1D]=getEqu1D_num('x',set,f1D_x,BinfoWOI.Interval_x,...
      poe1D,i_MR,i_zPlatform, i_sign); 
    end

% % % %     %% For y
% % % %     % Get B vector components along y0 (line) for fixed x0 and z0
% % % %     [B1D_y]=getB1D('y',0,i_zB,Bmatfile,BinfoWOI);
% % % %     % Get f1D_y of that line 
% % % %     f1D_y=m.y*B1D_y.y+m.z*B1D_y.z;
% % % %     
% % % %     if set.polynomial==1  % Analytical approach
% % % %        % local extrema in y (with x=0)
% % % %        [poe1D]=getEqu1D_poly('y',set,f1D_y,BinfoWOI.Interval_y,...
% % % %           poe1D,i_MR,i_zPlatform, i_sign);
% % % %     else                  % Numerical approach
% % % %        [poe1D]=getEqu1D_num('y',set,f1D_y,BinfoWOI.Interval_y,...
% % % %           poe1D,i_MR,i_zPlatform, i_sign);
% % % %     end
end