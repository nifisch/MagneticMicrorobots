%% getEqu1D_num
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getEqu1D.m
% Description:  Get poe in 1D - numerically
%-------------------------------------------------------------------------
function [poe1D]=getEqu1D_num...
    (inp,set,f,interval,poe1D,i_MR,i_zPlatform,i_sign)

% Paste x or y (inp) to find the right struct field in poe
formPOEpos=[inp,'pos'];
formPOEcenter=[inp,'center'];
formPOEneg=[inp,'neg'];
  
% [fmax,imax,~,~] = extrema2(f);
[~,locs] = findpeaks(f);
% [fmax,imax,fmin,imin] = extrema(f);

for i_poe = 1:length(locs)
    poe_candidate=abs(interval(locs(i_poe)));
    if poe_candidate<set.a
        poe=interval(locs(i_poe));
    else
        poe=nan;
    end
    
 	% Save Maximum points in proper array
    if i_sign==1
        poe1D.(formPOEpos)(i_MR,i_zPlatform,i_poe)=poe;
    elseif i_sign==2
        poe1D.(formPOEneg)(i_MR,i_zPlatform,i_poe)=poe;
    elseif i_sign==3
        poe1D.(formPOEcenter)(1,i_zPlatform,i_poe)=poe;
    end 
end       