%% getMoment_m
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190801
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      Equilibrium.m (main)
% Description:  Computes magnetic moment m for specific input (alpha)
%-------------------------------------------------------------------------
function [m]=getMoment_m(set,i_sign,i_MR,M)

if i_sign==1 || i_sign==2
    MR=set.MR_half(i_MR);
elseif i_sign==3  
    MR=0;
end

% Modify sign  
     if i_sign==1
         MRsigned=MR;     % Consider input>0
     elseif i_sign==2        
         MRsigned=-MR;    % Consider input<0
     elseif i_sign==3         
         MRsigned=0;         % Consider input=0
     end
      
    % Find row for angle or d and the according Bx, By, Bz
    if set.MR=='alpha'
        temp=set.magneticAngleTolerance;
        row=find(abs(M.alpha-MRsigned)<temp);
        while isempty(row)==1
            temp=temp+0.01;
            row=find(abs(M.alpha-MRsigned)<temp);
         end
    elseif set.MR=='d'
        temp= set.dTolerance;
        row=find(abs(M.d_inx-MRsigned)<temp);
            while isempty(row)==1
            temp=temp+1;
            row=find(abs(M.alpha-MRsigned)<temp);
            end
    end
     
    % Form magnetic moments in x y z
    m.x=M.BInterpolx(row(1));
    m.y=M.BInterpoly(row(1));
    m.z=M.BInterpolz(row(1)); 
    
%     % test for rotation ----------------
%     
%     load ('rotationmatrix.mat')
%     
%     mvec=[m.x;m.y;m.z];
%     mvecrot=R*mvec;
%     
%     m.x=mvecrot(1);
%     m.y=mvecrot(2);
%     m.z=mvecrot(3);