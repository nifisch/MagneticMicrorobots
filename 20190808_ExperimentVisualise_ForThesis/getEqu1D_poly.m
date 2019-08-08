%% getEqu1D_poly
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getEqu1D.m (function)
% Description:  Takes f_num and fits a polynome to it (along x or y axis)
%               allowing a polynomial approach and serving with 
%               equilibria points as output in one dimension.
%-------------------------------------------------------------------------
function [poe1D]=getEqu1D_poly...
    (inp,set,f_num,axisVals,poe1D,i_MR,i_zPlatform, i_sign)

% Paste x or y (inp) to find the right struct field in poe
formPOEpos=[inp,'pos'];
formPOEcenter=[inp,'center'];
formPOEneg=[inp,'neg'];

syms p; % Represents x or y

[f_poly1D,zeropoints]=get_f_poly_1D(set,axisVals,f_num);

% Collect k times zero point (zero crossings)
 for i_poe=1:length(zeropoints)
     poe=double(vpa(zeropoints(i_poe)));
     temp=double(subs(f_poly1D.pp,p,poe));
    if temp<0 && ...
        imag(zeropoints(i_poe))==0 ... % Check u''(p)<0 & exclude complex
        && abs(poe)<set.a % Additonel requirement to plot all equ points
     
        % Save zeo crossings in proper arrays, Only if u'(z)=0 & u''(z)<0        
        if i_sign==1
            poe1D.(formPOEpos)(i_MR,i_zPlatform,i_poe)=poe;
        elseif i_sign==2
            poe1D.(formPOEneg)(i_MR,i_zPlatform,i_poe)=poe;
        elseif i_sign==3
            poe1D.(formPOEcenter)(1,i_zPlatform,i_poe)=poe;
        end 
    end
 end 