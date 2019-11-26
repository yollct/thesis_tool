#!/bin/bash
read -p "Enter the name of the results folder: " data
read -p "Enter the number of clusters to filter e.g. 1 2 3...: " clusters

if [ "$clusters" == "all" ]
then
    IFS=$"\n" read -d " " -r -a all_clusters  < "/nfs/home/students/chit/Thesis/results/$data/all_clusters.txt"
    for all_cluster in $all_clusters
    do 
       Rscript filter_cluster.R $data $all_cluster
       echo Cluster $all_cluster is saved as clust$all_cluster.csv in $data.
    done
else
    for cluster in $clusters
    do
      Rscript filter_cluster.R $data $cluster
      echo Cluster $cluster is saved as clust$cluster.csv in $data.
    done
fi
