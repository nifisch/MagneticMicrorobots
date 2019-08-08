%% getEqu2D_poly
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getEqu2D.m
% Description:  Get poe in 2D - polynomial (fitting surface approach)
%-------------------------------------------------------------------------
function [poe]=getEqu2D_poly(set,f_num,X,Y)  

syms x y;

[f_analy2D]=get_f_poly_2D(set,X,Y,f_num);

equsystem=[f_analy2D.x==0; f_analy2D.y==0];
zp=vpasolve(equsystem,x,y);

poe_candidates=[double(vpa(zp.x)),double(vpa(zp.y))]; % Might be poe
s=size(poe_candidates);

D=f_analy2D.xx*f_analy2D.yy-f_analy2D.xy^2; % Maxima for D(x,y)>0
                                            % and for f_xx<0
j=1;
for i_poe=1:s(1)
    
    D_i=double(subs(D,[x,y],[poe_candidates(i_poe,1),...
        poe_candidates(i_poe,2)]));
    
    f_xx_i=double(subs(f_analy2D.xx,[x,y],...
        [poe_candidates(i_poe,1),poe_candidates(i_poe,2)]));
    
    if D_i>0 && f_xx_i<0
        poe(j,:)=[poe_candidates(i_poe,1),poe_candidates(i_poe,2)];
    else
        poe(j,1)=nan;
         poe(j,2)=nan;
    end
    j=j+1;
end
poe=nanmean(poe);