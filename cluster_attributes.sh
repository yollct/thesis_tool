#!/bin/bash

read -p "Enter the name of the result folder: " data
read -p "Enter the clusters you want to set the attributes eg:1 2 3 ..." clusters
if [ "$clusters" == "all" ]
then
    IFS=$"\n" read -d " " -r -a all_clusters  < "/home/chit/Desktop/Thesis/results/$data/all_clusters.txt"
    
    python3.7 cluster_attributes.py $data $all_clusters
    echo The graphml file with term attributes is in $data folder as term_connectivity.graphml.
else 
    python3.7 cluster_attributes.py $data $clusters
    echo The graphml file with term attributes is in $data folder as term_connectivity.graphml.
fi