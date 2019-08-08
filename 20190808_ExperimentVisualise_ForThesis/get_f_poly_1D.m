%% get_f_poly_1D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190806
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getPoe1D.m
% Description:  Provides f_poly derived from fitted f along x-axis
%-------------------------------------------------------------------------
function   [f_poly1D,zeropoints]=get_f_poly_1D(set,input_0,f_num)

% Fit f before processing gradient to obtain analytical solution
syms p;                                
coeffs=coeffvalues(fit_f1D(set,input_0, f_num));
f_poly1D.polynom=poly2sym(coeffs,p);    % Polynom u(p) = f
f_poly1D.p=diff(f_poly1D.polynom);  % 1. derivative u'(p) (Force F)
f_poly1D.pp=diff(f_poly1D.p);       % 2. derivative u''(p)
zeropoints=vpa(root(f_poly1D.p));