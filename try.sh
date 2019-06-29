#! /bin/bash
read -p "data" data

filepath="/home/chit/Desktop/Thesis/results/$data/all_clusters.txt"
IFS=$"\n" read -d " " -r -a clusters  < $filepath

for cl in $clusters
do 
    echo $cl
done
    
echo $filepath
