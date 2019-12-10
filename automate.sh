#!/bin/bash

##-d enter the name of folder
##high log odd automation
#job - term
while getopts d:j: option
do
case "${option}"
in 
d) data=${OPTARG};;
j) job=${OPTARG};;
esac
done

##get all cluster in cluster network
python3 firstscript.py $data
echo Clusters are extracted from network.

##read the cluster in highlogodd file
IFS= read -d "" -r -a high_log_odd  < "/nfs/home/students/chit/Thesis/results/$data/high_log_odd.txt"
echo $high_log_odd
python3 combine_cluster.py $data 
echo clust_highlog.txt is saved in $data folder.

cd /nfs/home/students/chit/myDAVIDAPI/PythonClient
case $job in
    "termenrich") python DAVIDtermenrich.py $data ;;              
    "chart") python DAVIDenrich.py $data ;;
esac
cd /nfs/home/students/chit/Thesis/thesis_tool
echo Finished running Cluster $all.

