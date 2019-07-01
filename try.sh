#! /bin/bash


read -p 'Enter the name of the results folder: ' data
read -p 'Enter the name of the cluster file(c1_c2): ' clusters

IFS=$"\n" read -d " " -r -a all_clusters  < "/home/chit/Desktop/Thesis/results/$data/all_clusters.txt"
    
python try.py $all_clusters

