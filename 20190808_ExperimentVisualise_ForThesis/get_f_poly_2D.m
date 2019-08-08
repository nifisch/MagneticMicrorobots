%% get_f_poly_2D
%-------------------------------------------------------------------------
% Subject:      Microrobot Manipulation at gas/liquid interface
% Date:         20190808
% Supervisor:   Antoine BARBOT
% Author:       Nikola FISCHER   
% Used by:      getEqu2D_poly.m
% Description:  Provides f_poly derived from fitted f
%-------------------------------------------------------------------------
function   [f_poly2D]=get_f_poly_2D(set,X,Y,f_num)

% Fit f before processing gradient to obtain analytical solution
[fitresult,~] = fit_f2D(set,X, Y, f_num);

syms x y;  % In general p
c=coeffvalues(fitresult);
% f_analy2D.polynom=c(1)+c(2)*x+...       
%                 c(3)*y+...
%                 c(4)*x^2+...
%                 c(5)*x*y+...
%                 c(6)*y^2+...
%                 c(7)*x^3+...
%                 c(8)*x^2*y+...
%                 c(9)*x*y^2+...
%                 c(10)*y^3;
p00=fitresult.p00;
p10=fitresult.p10;
p01=fitresult.p01;
p20=fitresult.p20;
p11=fitresult.p11;
p02=fitresult.p02;
p30=fitresult.p30;
p21=fitresult.p21;
p12=fitresult.p12;
p03=fitresult.p03;
p40=fitresult.p40;
p31=fitresult.p31;
p22=fitresult.p22;
p13=fitresult.p13;
p04=fitresult.p04;
p50=fitresult.p50;
p41=fitresult.p41;
p32=fitresult.p32;
p23=fitresult.p23;
p14=fitresult.p14;
p05=fitresult.p05;

% Polynom u(p) = f
f_poly2D.polynom=p00 + p10*x + p01*y + p20*x^2 + p11*x*y + p02*y^2 +...
    p30*x^3 + p21*x^2*y + p12*x*y^2 + p03*y^3 + p40*x^4 + p31*x^3*y + ...
    p22*x^2*y^2 + p13*x*y^3 + p04*y^4 + p50*x^5 + p41*x^4*y+ ...
    p32*x^3*y^2 + p23*x^2*y^3 + p14*x*y^4 + p05*y^5;
            
f_poly2D.x=diff(f_poly2D.polynom,x);     % 1. derivative u'(p) (Force F)
f_poly2D.xx=diff(f_poly2D.x);            % 2. derivative u''(p)
f_poly2D.y=diff(f_poly2D.polynom,y);     % 1. derivative u'(p) (Force F)
f_poly2D.yy=diff(f_poly2D.y);            % 2. derivative u''(p)
f_poly2D.xy=diff(f_poly2D.x,y);