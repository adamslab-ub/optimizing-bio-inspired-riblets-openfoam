#!/bin/bash
cd $1
cd ./2.000
mkdir ../../datasetOutputs/$2
cp ./new_data0.csv ../../datasetOutputs/$2/
cp ./*.dat ../../datasetOutputs/$2/

