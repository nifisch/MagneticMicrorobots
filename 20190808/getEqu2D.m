%% getEqu2D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Get poe in 2D
%-------------------------------------------------------------------------
function [poe2D]=getEqu2D(set,poe2D,i_z,i_sign,i_alpha,Bmatfile,BinfoWOI,m)  

if set.dimension==2 % Solution for 2D wanted
    i_zPlatform=i_z(1);
    i_zB=i_z(2);
    
    % General calculation of f, necessary for analy and num
    for i_x=1:BinfoWOI.nbpoints_x
        for i_y=1:BinfoWOI.nbpoints_y
            Bx=Bmatfile.x(i_x,i_y,i_zB);
            By=Bmatfile.y(i_x,i_y,i_zB);
            Bz=Bmatfile.z(i_x,i_y,i_zB);

            f(i_x,i_y)=m.x*Bx+m.y*By+m.z*Bz;
        end
    end

    [X,Y]=meshgrid(BinfoWOI.Interval_y,BinfoWOI.Interval_x);

    X=double(X);
    Y=double(Y);
    f=double(f);

    if set.polynomial==1 
    % Polynomial Approach
    [poe]=getEqu2D_poly(set,f,X,Y);
  
    elseif set.polynomial==0
    % Numerical Approach   
    [poe]=getEqu2D_num(BinfoWOI,f,set,X,Y,i_zPlatform,i_sign,i_alpha);  
    end
    
    % General poe treatment in proper array 
    s=size(poe);

     for i_poe = 1:s(1)
       if abs(poe(i_poe,1))<=set.a && abs(poe(i_poe,2))<=set.a && ...
               i_poe<=set.peq

            % Save Maximum points in proper array
            if i_sign==1
    %           if z(k,1)>=0
                poe2D.xpos(i_alpha,i_zPlatform,i_poe)=poe(i_poe,1);
                poe2D.ypos(i_alpha,i_zPlatform,i_poe)=poe(i_poe,2);
            elseif i_sign==2
    %           elseif z(k,1)<0
                poe2D.xneg(i_alpha,i_zPlatform,i_poe)=poe(i_poe,1);
                poe2D.yneg(i_alpha,i_zPlatform,i_poe)=poe(i_poe,2);
            elseif i_sign==3
                poe2D.xcenter(1,i_zPlatform,i_poe)=poe(i_poe,1);
                poe2D.ycenter(1,i_zPlatform,i_poe)=poe(i_poe,2);              
            end    
       end  
    end
end