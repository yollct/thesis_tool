#!/bin/bash


read -p 'Enter the name of the results folder: ' data
read -p 'Enter the name of the cluster file(c1_c2): ' clusters
read -p "Enter the DAVID analysis (termenrich/chart): " job
if [ "$clusters" == "all" ]
then
    IFS=$"\n" read -d " " -r -a all_clusters  < "/data/home/students/chit/Desktop/Thesis/results/$data/all_clusters.txt"
    for all_cluster in $all_clusters
    do
        python txt2csv.py $data $all_cluster
        echo Cluster $all_cluster file is converted to txt.

        cd /data/home/students/chit/PythonClient-1.1/PythonClient
        case $job in
            "termenrich") python DAVIDtermenrich.py $data $all_cluster ;;              
            "chart") python DAVIDenrich.py $data $all_cluster ;;
        esac
        cd /data/home/students/chit/Thesis/thesis_tool
        echo Finished running Cluster $all_cluster.
    done
else
    for cluster in $clusters
    do
        python txt2csv.py $data $cluster
        echo Cluster $cluster file is converted to txt.

        cd /data/home/students/chit/PythonClient-1.1/PythonClient
        case $job in
            "termenrich") python DAVIDtermenrich.py $data $cluster ;;              
            "chart") python DAVIDenrich.py $data $cluster ;;
        esac
        cd /data/home/students/chit/Thesis/thesis_tool
        echo Finished running Cluster $cluster.
done
fi
