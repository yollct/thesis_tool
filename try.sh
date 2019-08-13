#! /bin/bash

read -p "data" data
read -p "cls " cll

if [ -e /home/chit/Desktop/Thesis/results/$data/clust$cll.txt.termClusteringReport.txt ];
then    
    echo yes
else
    echo no
fi

