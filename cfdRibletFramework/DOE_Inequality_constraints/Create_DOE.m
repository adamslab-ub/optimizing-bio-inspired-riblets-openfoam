clc
clear all
format short
close all

%% Generate DOE
nSamples = 30;
nVariables = 3;

A = [6 -1 0; 0 1 -6; 1 0 -0.6];
b = [0;0;0];

x = lhsdesigncon(nSamples,nVariables,[0.12 0.72 0.2],[0.36 3.6 0.6],[false false],A,b);
x = round(x,3,'significant');
y(:,1) = x(:,3);
y(:,2) = x(:,2);
y(:,3) = x(:,1);

save(strcat('TSF_',num2str(date),'.mat'),'y');
disp("    sigma    spacing      height")

%% Save DOE into .dat file
fid = fopen('variables.dat','w');

for i=1:nSamples
    for j=1:nVariables
        fprintf(fid,"%0.4f\t",y(i,j));
    end
    fprintf(fid,"\n");
end
% fprintf(fid,"\n");
fclose(fid);
%%

% A = [2 -1;-6 1]
% b = [0 ; 0]
% y1 = linspace(0,5,100);
% z1 = 6*y1;
% y2 =  2*y1;
% y2 = 2*y1;
% x = lhsdesigncon(20,2,[0.2 0.4],[0.6 3.6],[false false],A,b);
% x = round(x,3,'significant');
% figure(1)
% plot(x(:,1),x(:,2),'*')
% hold on
% plot(y1,y2)
% hold on
% plot(y1,z1)
% hold on
% plot(0.2*ones(size(y1)),y1)
% hold on
% plot(0.6*ones(size(y1)),y1)
% 
% xlim([0 1])
% ylim([0 5])
% xlabel('Gaussian height')
% ylabel('Gaussian Spacing')
% title('Latin Hypercube sampling with inequality constraints')
%x = lhsdesigncon(10000,2,[-100 1e-1],[100 1e2],[false true],A,b);