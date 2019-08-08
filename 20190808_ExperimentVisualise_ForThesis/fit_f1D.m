%% fit_f1D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190807
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      get_f_analytic_1D
% Description:  Takes F_Rd_num and fits a polynome to it, allowing an
%               analytical approach and serving with equilibria points 
%               as output.
%-------------------------------------------------------------------------
function [fitresult, gof] = fit_f1D(set, u, fu)
%% Fit: 'numanfit'.

if length(u)<=7
    u=[0;0;0;u;0;0;0];
    fu=[0;0;0;fu;0;0;0];
end

[xData, yData] = prepareCurveData( u, fu );

% Set up fittype and options.
ft = fittype( set.fit_polynome1D );

% Fit model to data.

if set.fit_intervallsection==1
    % Exclude data
    outliers = excludedata(xData,yData,'domain',[-set.a,set.a]);
else 
    outliers = excludedata(xData,yData,'domain',[-set.amax,set.amax]);
end

[fitresult, gof] = fit( xData, yData, ft, 'Exclude',outliers,...
    'Normalize', set.fit_centscale1D);

if set.vis1Dfit==1   
    % Plot fit with data.
    figure( 'Name', 'numanfit' );
    plot( fitresult, xData, yData );
    % Label axes
    xlabel x
    ylabel f
    grid on
end