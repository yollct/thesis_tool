#! /bin/bash

function myDAVID(){
    ##args1 = results folder
    ##args2 = cluster
      
    cd /home/chit/PythonClient-1.1/PythonClient
    python DAVIDtermenrich.py $@
    cd /home/chit/Desktop/Thesis/thesis_tool
    echo Finished!
}

function DAVIDchartreport(){
    ##args1 = results folder
    ##args2 = cluster
      
    cd /home/chit/PythonClient-1.1/PythonClient
    python DAVIDenrich.py $@
    cd /home/chit/Desktop/Thesis/thesis_tool
    echo Finished!

}

function combinecluster(){
    #arg1 results folder
    #arg2 + 3 clusters to combine

    echo Combining cluster $2 and cluster $3 from $1 results.
    python combine_cluster.py $@
    echo The combined file is clust$2_$3.csv in $1 folder.
}

function filtercluster(){
    #arg1 results folder
    #arg2 cluster to filter

    python filter_cluster.py $@
    echo The filtered cluster is saved as clust$2.csv in $1 folder
}

function filtercluster_ensembl(){
    #arg1 results folder
    #arg2 cluster #
    Rscript filter_cluster.R $@
    echo The filtered cluster is saved as clust$2_ens.csv in $1 folder.

}

