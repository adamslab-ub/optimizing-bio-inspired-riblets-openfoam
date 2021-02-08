#!/bin/bash
#SBATCH --error=cad.err
#SBATCH --output=cad.out
#SBATCH --job-name=cad
##SBATCH --mail-user=sumeetsa@buffalo.edu
##SBATCH --mail-type=ALL
#SBATCH --time=10:00:00
#SBATCH --mem=256000
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
##SBATCH --exclusive
##SBATCH --partition=debug
#SBATCH --partition=largemem
#SBATCH --qos=largemem

# load module
module load salome
ulimit -s unlimited

./makeCfdRun.sh
