

### Retrieving pressure distribution from each sample output

1. In copyOpenFOAMProcessedData.sh rename 2.000 with the correct aoa value 

2. Run ./copyOpenFOAMProcessedData.sh directoryName sampleNo


### To tar archive all folders:
1. ls > fileList.txt
2. Edit fileList.txt and remove those items you don't want to be tar archive.
3. Run ./tarListOfFiles fileList.txt