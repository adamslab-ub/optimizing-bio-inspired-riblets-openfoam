#!/bin/bash
#SBATCH --error=log-%j.err
#SBATCH --output=log-%j.out
##SBATCH --mail-user=payamgha@buffalo.edu
##SBATCH --mail-type=ALL
#SBATCH --time=48:00:00
#SBATCH --mem=256000
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --tasks-per-node=32
#SBATCH --exclusive
##SBATCH --partition=largemem
##SBATCH --qos=largemem
##SBATCH --constraint=IB
##SBATCH --partition=debug
