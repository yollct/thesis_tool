#!/bin/bash
# before this:: get all the clusters txt file
# automate combining clusters with connection, and then david enrich


read -p 'Enter the name of the results folder: ' data
read -p 'The job in david (termenrich, chart): ' job

IFS=$"\n" read -d " " -r -a all_clusters  < "/home/chit/Desktop/Thesis/results/$data/all_connect.txt"
    
for all in $all_clusters
do 
    python3 combine_cluster.py $data $all
    echo Cluster$all.txt is saved in $data folder.

    python3 txt2csv.py $data $all
    echo Cluster $all_cluster file is converted to txt.

    cd /home/chit/PythonClient-1.1/PythonClient
    case $job in
        "termenrich") python DAVIDtermenrich.py $data $all ;;              
        "chart") python DAVIDenrich.py $data $all;;
    esac
    cd /home/chit/Desktop/Thesis/thesis_tool
    echo Finished running Cluster $all.
done