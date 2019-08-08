%% interpolateWOI - Workspace of Interest
%------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190723
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      addMagnet.m
% Description:  Interpolates Bnew in 3D within workspace of interest
%------------------------------------------------------------------------
function [BInterpol]=interpolateWOI(B,Binfo,BinfoWOI)

%  Creates query points (= where shall it interpolate)
xq = BinfoWOI.Interval_x;                     
yq = BinfoWOI.Interval_y;   
zq = BinfoWOI.Interval_z;  

% Prepare interpolation with mesh
[Xq,Yq,Zq]=meshgrid(yq,xq,zq); % Note: xq and yq are swapped
[X,Y,Z]=meshgrid(Binfo.Interval_y,Binfo.Interval_x,Binfo.Interval_z);

% Save new intervalls
Binfo.Interval_x=xq';
Binfo.Interval_y=yq';
Binfo.Interval_z=zq';
clear xq yq zq

% Test: griddata
Xq=double(Xq);
Yq=double(Yq);
Zq=double(Zq);
X=double(X);
Y=double(Y);
Z=double(Z);
B.x=double(B.x);
B.y=double(B.y);
B.z=double(B.z);

% BInterpol.x=griddata(X,Y,Z,B.x,Xq,Yq,Zq);
% BInterpol.y=griddata(X,Y,Z,B.y,Xq,Yq,Zq);
% BInterpol.z=griddata(X,Y,Z,B.z,Xq,Yq,Zq);


% % Interpolate
BInterpol.x=interp3(X,Y,Z,B.x,Xq,Yq,Zq,'spline');
BInterpol.y=interp3(X,Y,Z,B.y,Xq,Yq,Zq,'spline');
BInterpol.z=interp3(X,Y,Z,B.z,Xq,Yq,Zq,'spline');

clear X Y Z Xq Yq Zq
end