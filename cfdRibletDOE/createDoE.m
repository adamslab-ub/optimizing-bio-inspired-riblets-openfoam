function X = createDoE(nSamples)
%Generate DoE for CFD Riblet simulation
%
%  Copyright 2019 ADAMS Lab.
%  Author: Payam Ghassemi
%  Email: payamgha@buffalo.edu
%
% Equations:
% f = D(x) \\
% s.t.
% g_1(x): 6*sigma - spacing <= 0
% g_2(x): spacing - 6*height <= 0
% g_3(x): sigma - 0.6*height <= 0
% 0.2 <= height <= 0.6
% 0.72 <= spacing <= 3.6
% 0.12 <= sigma <= 0.46
% x = [height, spacing, sigma];
% X = [height, spacing, sigma, angle of attack];

format short

nVariables = 3;

A = [0 -1 6; -6 1 0; -0.6 0 1];
b = [0;0;0];
angleOfAttack = 2;
X = lhsdesigncon(nSamples,nVariables,[0.2 0.72 0.12],[0.6 3.6 0.46],[false false],A,b);
X = [X, ones(nSamples,1)*angleOfAttack];
X = round(X,3,'significant');

end

