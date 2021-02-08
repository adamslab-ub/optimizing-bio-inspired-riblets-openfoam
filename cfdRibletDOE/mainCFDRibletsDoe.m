% Generate Dataset for CFD Riblets with Gaussian shape and its three
% parameters
% Payam Ghassemi, October 2019

nSamples = 30;
X = createDoE(nSamples);
y = cfdRun(X);
