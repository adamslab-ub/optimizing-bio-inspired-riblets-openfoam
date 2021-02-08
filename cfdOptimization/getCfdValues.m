function J = getCfdValues()
%Download and return results of CFD riblet simulation
%
%  Copyright 2020 ADAMS Lab.
%  Author: Payam Ghassemi
%  Email: payamgha@buffalo.edu

[status, cmdout] = system('scp -r vortex.ccr.buffalo.edu:/gpfs/scratch/payamgha/cfdRibletFramework/data/values.dat ./');
[status, cmdout] = system('cat values.dat|wc -l');
[status, cmdout] = system('sh parse.sh');

format long;
zero = importdata('zero.dat');

X = zero(:,[1:3]);
data.yDrag= zero(:,5);
%   data.yLift = zero(:,6);
J = data.yDrag;
system('echo "echo -n > /gpfs/scratch/payamgha/cfdRibletFramework/data/values.dat" |ssh vortex.ccr.buffalo.edu /bin/bash');
disp('Cleaned values file!');

end
