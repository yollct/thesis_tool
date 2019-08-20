#!/bin/bash
#do david analysis for specified clusters or for all cluster 

read -p 'Enter the name of the results folder: ' data
read -p 'Enter the name of the cluster file(c1_c2): ' clusters
read -p "Enter the DAVID analysis (termenrich/chart): " job
if [ "$clusters" == "all" ]
then
    IFS=$"\n" read -d " " -r -a all_clusters  < "/home/chit/Desktop/Thesis/results/$data/all_clusters.txt"
    for all_cluster in $all_clusters
    do
        if [ -e /home/chit/Desktop/Thesis/results/$data/clust$all_cluster.txt.termClusteringReport.txt ]
        then
            echo cluster $all_cluster is finished!
            continue
        else
            python txt2csv.py $data $all_cluster
            echo Cluster $all_cluster file is converted to txt.

            cd /home/chit/myDAVIDAPI/PythonClient
            case $job in
               "termenrich") python DAVIDtermenrich.py $data $all_cluster ;;              
                "chart") python DAVIDenrich.py $data $all_cluster ;;
            esac
            cd /home/chit/Desktop/Thesis/thesis_tool
            echo Finished running Cluster $all_cluster.
        fi
    done
else
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
fi
