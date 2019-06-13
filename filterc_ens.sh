#!/bin/bash
read -p "Enter the name of the results folder: " data
read -p "Enter the number of clusters to filter e.g. 1 2 3...: " clusters

for cluster in $clusters
do
  Rscript filter_cluster.R $data $cluster
  echo Cluster $cluster is saved as clust$cluster.csv in $data.
done
