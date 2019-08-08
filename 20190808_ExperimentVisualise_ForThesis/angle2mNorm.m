%% angle2mNorm
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190716
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Get normalised magnetic moment using angles
%-------------------------------------------------------------------------
function   [mNormx,mNormy]=angle2mNorm(alpha)

% Define m0 as a horizontal vector of length 1, in direction of x
m0x=[-1 0 0]';
% Define m0 as a horizontal vector of length 1, in direction of y
m0y=[0 1 0]';

%% Define rotational matrice
% R (rotation of alpha about y-axis or x-axis)
Ry=[ cos(alpha), 0 ,sin(alpha); ...
            0, 1 ,0; ...
            -sin(alpha), 0, cos(alpha)];
        
Rx=[  1,0,0;...
            0,cos(alpha),-sin(alpha);...
            0,sin(alpha),cos(alpha)];
          
% Get rotated magnetic moment
mx=Ry*m0x;
my=Rx*m0y;

mNormx.Rx=mx(1);
mNormx.Ry=mx(2);
mNormx.Rz=mx(3);

mNormy.Rx=my(1);
mNormy.Ry=my(2);
mNormy.Rz=my(3);