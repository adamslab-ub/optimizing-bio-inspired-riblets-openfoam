#/bin/bash

cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>0 && NR<21' >2_negative_data.dat
cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>20 && NR<41' >zero_data.dat
cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>40 && NR<61' >two_data.dat
cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>60 && NR<81' >four_data.dat
cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>80 && NR<101' >six_data.dat
cat values.dat|column -t |sort -n -k1|awk '{print $2"\t"$3"\t"$4"\t"$5}'|awk 'NR>100 && NR<121' >eight_data.dat

