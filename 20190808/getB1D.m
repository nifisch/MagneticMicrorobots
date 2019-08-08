%% getB1D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190718
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      verifyEQ3ang.m (function)
% Description:  Get B1d vector components along x or y for fixed y0,x0,z0
%-------------------------------------------------------------------------

% input1 (string): Along which axis shall the B field be computed?
% input2_0 (num) : At which value remaining variable shall be constant?

function [B1D]=getB1D(input1,input2_0,i_zB,Bmatfile,Binfo)

% Create B vector components for that surface
if input1 == 'x'
    % Find index for input2_0
    i_y_0=find((abs(Binfo.Interval_y-input2_0)<=0.5*Binfo.stepsize_y));
    
    B1D.x=Bmatfile.x(:,i_y_0,i_zB);
    B1D.y=Bmatfile.y(:,i_y_0,i_zB);
    B1D.z=Bmatfile.z(:,i_y_0,i_zB);
elseif input1 == 'y'
    % Find index for input2_0
    i_x_0=find((abs(Binfo.Interval_x-input2_0)<=0.5*Binfo.stepsize_x));
    
    B1D.x=(Bmatfile.x(i_x_0,:,i_zB))';
    B1D.y=(Bmatfile.y(i_x_0,:,i_zB))';
    B1D.z=(Bmatfile.z(i_x_0,:,i_zB))';
end 