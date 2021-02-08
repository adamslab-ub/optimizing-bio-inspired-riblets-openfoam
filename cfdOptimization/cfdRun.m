function J = cfdRun(X)
%Run CFD Riblet simulation
%
%  Copyright 2019 ADAMS Lab.
%  Author: Sumeet Lulekar, Payam Ghassemi
%  Email: payamgha@buffalo.edu

    % Launch CAD, Meshing and CFD
        writeDate = date();
        %Function saves the matrix format into a .dat file    
        fileName = strcat('variables',num2str(writeDate),'.dat');
        fid = fopen(fileName,'w');
        fid1= fopen("variablesCopy.dat","w");
        array_length = size(X(:,1))
        
        for i=1:array_length(1,1) % X = [height, spacing, sigma, angle of attack]
            fprintf(fid,'%4.3f\t%4.3f\t%4.3f\t%2.3f\n',X(i,1),X(i,2),X(i,3),X(i,4));
            fprintf(fid1,'%4.3f\t%4.3f\t%4.3f\t%2.3f\n',X(i,1),X(i,2),X(i,3),X(i,4));
        end
        fclose(fid);
        fclose(fid1);
        [status, cmdout] = system(strcat('scp -r ./',fileName, ' vortex.ccr.buffalo.edu:/gpfs/scratch/payamgha/cfdRibletFramework/variables.dat'));
        n = 0;

    [status, cmdout] = system('echo "./launchCfdSimulation.sh" | ssh vortex.ccr.buffalo.edu /bin/bash');
    disp('Launched CAD Model!');
    m = 0;
        while(m<=array_length(1,1))
            [status, cmdout] = system('scp -r vortex.ccr.buffalo.edu:/gpfs/scratch/payamgha/cfdRibletFramework/data/values.dat ./');
            [status, cmdout] = system('cat values.dat|wc -l');
            m = str2num(cmdout)
            disp(array_length(1,1))
            if m==array_length(1,1)
                disp('Simulation Finished.')
                pause
                disp('Are you sure?')
                pause
                break;
            else
                disp('Simulation Paused.')
                pause(300)
            end
        end
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
