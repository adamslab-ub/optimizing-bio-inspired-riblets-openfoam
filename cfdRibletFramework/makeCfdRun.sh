#!/bin/bash
#title           :makeCfdRun.sh
#description     :This script generates all required files for each sample and run the CFD.
#author		 :Sumeet Lulekar, and Payam Ghassemi
#date            :Nov 02, 2019
#version         :2.0    
#usage		 :bash makeCfdRun.sh
#notes           :Install OpenFoam, and SALOME.
#==============================================================================

folderOutputName="output"
echo -n > ./foamCase/designVariables.dat #[height, space, sigma, angle of attack]
while read -r line;
do
    echo $line > inputVariables.dat
    gau_height=$(echo $line | awk '{print $1}')
    gau_space=$(echo $line | awk '{print $2}')
    gau_sigma=$(echo $line | awk '{print $3}')
    angleOfAttack=$(echo $line | awk '{print $4}')
    caseName=$gau_height$gau_space$gau_sigma
    mkdir -p ./$folderOutputName/$caseName
    mkdir -p ./$folderOutputName/$caseName/$angleOfAttack

    echo 'Created the case folder!'

    # copy CFD necessary files to corrspoding case folder.
    rm -rf ./foamCase/openfoam-slurm-script.slurm
    cp -r ./foamCase/slurm-script.slurm ./foamCase/openfoam-slurm-script.slurm
    echo "#SBATCH --job-name=$angleOfAttack-$caseName"|tee -a ./foamCase/openfoam-slurm-script.slurm >/dev/null
    path=$(pwd)
    echo "cd $path/$folderOutputName/$caseName/$angleOfAttack"|tee -a ./foamCase/openfoam-slurm-script.slurm >/dev/null
    echo "./allRun"|tee -a ./foamCase/openfoam-slurm-script.slurm >/dev/null
    cp -r ./foamCase/* ./$folderOutputName/$caseName/$angleOfAttack/
    echo 'Copied foam Case!'

    # load modules 
    module load salome/8.2.0
    echo 'Loaded module!'

    salome -t generateCADModels.py

    echo 'Generated actualCadModel.stl file!'

    mv actualCadModel.stl ./$folderOutputName/$caseName/$angleOfAttack/constant/triSurface/motorBike.stl
    echo 'Move actualCadModel.stl to corresponding folders'

    cat Aref.dat|tee -a ./$folderOutputName/$caseName/$angleOfAttack/system/forceCoeffs > /dev/null

    echo -n > Aref.dat
    sbatch $path/$folderOutputName/$caseName/$angleOfAttack/openfoam-slurm-script.slurm

    rm -rf inputVariables.dat

    echo -e "$gau_height\t$gau_space\t$gau_sigma\t$angleOfAttack">$path/$folderOutputName/$caseName/$angleOfAttack/designVariables.dat

done < variables.dat

# Save variables to a separate file to track progress of generation
cp variables.dat latestVariables.dat
cat variables.dat|tee -a oldVariables.dat > /dev/null

# Clear the contents of the variables text file
echo -n > variables.dat
