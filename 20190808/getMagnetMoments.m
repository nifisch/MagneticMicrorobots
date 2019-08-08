%% getMagnetMoments
%------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190806
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER 
% Used by:      Equilibrium.m (main)
% Description:  Creates a list M of magnetic moments m for the MRs
%------------------------------------------------------------------------
function [M]=getMagnetMoments(set,B_1Magnet,Binfo)

if set.magmommeasured==1
    m_easured=impM_easured(fullfile(pwd,...
        'M_data','20190803_M_easurement.txt')); 

    toDelete =m_easured.y ~=0;
    m_easured(toDelete ,:) = [];
  
    %  Creates query points (= where shall it interpolate)
    xq = -30:set.interpolStepM:30;
    BInterpol.x=interp1(m_easured.x,m_easured.bx,xq);
    BInterpol.y=interp1(m_easured.x,m_easured.by,xq);
    BInterpol.z=interp1(m_easured.x,m_easured.bz,xq);
    
    s=size(BInterpol.x); 
    
    % Calculate alphas and betas depending on bx,by,bz
    for i_row=1:s(2)
        angl_alpha(i_row)=atan(BInterpol.z(i_row)/BInterpol.x(i_row));
        angl_beta(i_row)=atan(BInterpol.z(i_row)/BInterpol.y(i_row));
    end

    % Save in table form
    M=table(xq',angl_alpha',angl_beta',rad2deg(angl_alpha)',...
        rad2deg(angl_beta)',BInterpol.x',BInterpol.y',BInterpol.z');

    M.Properties.VariableNames = {'d_inx','alpha ','beta',...
        'alpha_deg','beta_deg','BInterpolx','BInterpoly','BInterpolz'}; 
    
%     toDelete =m_easured.y ~=0;
%     m_easured(toDelete ,:) = [];
%     s=size(m_easured);
% 
%     M=table(m_easured.x,...
%         nan(s(1),1),nan(s(1),1),...
%          nan(s(1),1),nan(s(1),1),...
%        m_easured.bx,m_easured.by,m_easured.bz);
% 
%     M.Properties.VariableNames = {'d_inx','alpha ','beta',...
%         'alpha_deg','beta_deg','BInterpolx','BInterpoly','BInterpolz'};      
else % simulate M  
    zi=find(abs(Binfo.Interval_z+set.altitudeMagnetisation)<...
        Binfo.stepsize_z/2);

    % Create Bx, By, Bz matrices for every point in the array
    B.x=B_1Magnet.x(:,:,zi);
    B.y=B_1Magnet.y(:,:,zi);
    B.z=B_1Magnet.z(:,:,zi);

    %  Creates query points (= where shall it interpolate)
    xq = Binfo.Intmin_x:set.interpolStepM:Binfo.Intmax_x;                     
    yq = Binfo.Intmin_y:set.interpolStepM:Binfo.Intmax_y;    

    % Prepare interpolation with mesh
    [Xq,Yq]=meshgrid(yq,xq); % Note: xq and yq are swapped
    [X,Y]=meshgrid(Binfo.Interval_y,Binfo.Interval_x);

    % Interpolate
%     BInterpol.x=interp2(X,Y,B.x,Xq,Yq,'spline');
%     BInterpol.y=interp2(X,Y,B.y,Xq,Yq,'spline');
%     BInterpol.z=interp2(X,Y,B.z,Xq,Yq,'spline');

    Xq=double(Xq);
    Yq=double(Yq);

    X=double(X);
    Y=double(Y);

    B.x=double(B.x);
    B.y=double(B.y);
    B.z=double(B.z);

    BInterpol.x=griddata(X,Y,B.x,Xq,Yq);
    BInterpol.y=griddata(X,Y,B.y,Xq,Yq);
    BInterpol.z=griddata(X,Y,B.z,Xq,Yq);
    
    % New intervalls
    Binfo.Interval_x=xq;
    Binfo.Interval_y=yq;
    Binfo.Interval_z=nan;
    % Number of data points
    Binfo.nbpoints_x=length(Binfo.Interval_x);% in x direction
    Binfo.nbpoints_y=length(Binfo.Interval_y);% in y direction
    Binfo.nbpoints_z=nan;% in z direction 
    % Stepsize
    Binfo.stepsize_x=mean(gradient(Binfo.Interval_x)); % in x direction
    Binfo.stepsize_y=mean(gradient(Binfo.Interval_y));% in y direction
    Binfo.stepsize_z=nan; % in z direction

    for i_x=1:Binfo.nbpoints_x
        for i_y=1:Binfo.nbpoints_y
            angl_alpha(i_x,i_y)=atan(BInterpol.z(i_x,i_y)/BInterpol.x(i_x,i_y));
            angl_beta(i_x,i_y)=atan(BInterpol.z(i_x,i_y)/BInterpol.y(i_x,i_y));
    %         angl_gamma(i_x,i_y)=atan(BInterpol.y(i_x,i_y)/BInterpol.x(i_x,i_y));
        end
    end

    % Transform angle arrays from rad to degree for better understanding
    angl_alpha_deg=rad2deg(angl_alpha);
    angl_beta_deg=rad2deg(angl_beta);
    % angl_gamma_deg=rad2deg(angl_gamma);

    % Get table for d, angle alpha, beta - table for MRs at y=0
    y0=find(abs(Binfo.Interval_y)<Binfo.stepsize_y/2);
    M=table(Binfo.Interval_x',...
        angl_alpha(:,y0),angl_beta(:,y0),...
        angl_alpha_deg(:,y0),angl_beta_deg(:,y0),...
        BInterpol.x(:,y0),BInterpol.y(:,y0),BInterpol.z(:,y0));

    M.Properties.VariableNames = {'d_inx','alpha ','beta',...
        'alpha_deg','beta_deg','BInterpolx','BInterpoly','BInterpolz'};
end