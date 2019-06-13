#!/bin/bash


read -p 'Enter the name of the results folder: ' data
read -p 'Enter the name of the cluster file(c1_c2): ' clusters
read -p "Enter the DAVID analysis (termenrich/chart): " job
for cluster in $clusters
do
    python txt2csv.py $data $cluster
    echo Cluster $cluster file is converted to txt.

    cd /home/chit/PythonClient-1.1/PythonClient
    case $job in
        "termenrich") python DAVIDtermenrich.py $data $cluster ;;              
        "chart") python DAVIDenrich.py $data $cluster ;;
    esac
    cd /home/chit/Desktop/Thesis/thesis_tool
    echo Finished running Cluster $cluster.
done