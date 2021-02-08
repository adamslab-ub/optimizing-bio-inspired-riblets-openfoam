% Sample template code for calling cfd-riblet framework for optimization.
%

%  Copyright 2021 ADAMS Lab.
%  Author: Payam Ghassemi, payamgha@buffalo.edu

%% Reset workspace
clc; clear all; close all;



fun = @(X) cfdRun(X); % function handler to call cfd-riblet framework

%% Bounds
lb = [0.2 0.72 0.12];
ub = [0.6 3.6 0.46];
nVar = 3;

x0 = (ub+lb)/2;
%% Optimization
x = fmincon(fun,x0,[],[],[],[],lb,ub);

