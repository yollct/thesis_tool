#!/bin/bash

read -p "Enter the name of the result folder: " data
read -p "Enter the clusters you want to set the attributes eg:1 2 3 ..." clusters

python cluster_attributes.py $data $clusters
echo The graphml file with term attributes is in $data folder as term_connectivity.graphml.