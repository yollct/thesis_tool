#! /bin/bash


read -p 'Enter the name of the results folder: ' data

IFS=$"\n" read -d " " -r -a all_clusters  < "/home/chit/Desktop/Thesis/results/$data/all_connect.txt"
    
for all in $all_clusters
do 
    echo $all
done
