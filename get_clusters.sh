#!/bin/bash

read -p "Enter the name of the result folder: " data

python get_clusters.py $data
echo Cluster number are saved in all_clusters.txt in $data.