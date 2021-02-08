#!/bin/bash
#title           :launchCfdSimulation.sh
#description     :This script executs makeCfdRun.
#author		 :Sumeet Lulekar, and Payam Ghassemi
#date            :Nov 02, 2019
#version         :2.0    
#usage		 :bash launchCfdSimulation.sh
#notes           :You need to change the path to a location you have CfdFramework directory. Install OpenFoam, and SALOME.
#==============================================================================

sbatch ./makeCfdRun_barefoil.sh
