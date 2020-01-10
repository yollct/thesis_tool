#!/bin/bash

##-d enter the name of folder
##high log odd automation
#job - term
while getopts d:j:p:c:s: option
do
case "${option}"
in 
d) data=${OPTARG};;
j) job=${OPTARG};;
p) pvalue=${OPTARG};; ##pvalue for filtering the edges
c) pcutoff=${OPTARG};; ##pvalue cutoff for plotting reactome plots
s) scale=${OPTARG};; ##scale for plotting emap and cnet
esac
done

##get all cluster in cluster network
python3 firstscript.py $data $pvalue
echo Clusters are extracted from network.

##read the cluster in highlogodd file
IFS= read -d "" -r -a high_log_odd  < "/nfs/home/students/chit/Thesis/results/$data/high_log_odd.txt"
echo $high_log_odd
python3 combine_cluster.py $data 
echo clust_highlog.txt is saved in $data folder.

Rscript ensemblid.R $data
echo Genes are converted to ensembl id.

#if [ -e /nfs/home/students/chit/Thesis/results/$data/highlogenes_ens.txt.termClusteringReport.txt ]
#then
#    echo Finished running DAVID!
#else            
cd /nfs/home/students/chit/myDAVIDAPI/PythonClient
case $job in
  "termenrich") python DAVIDtermenrich.py $data ;;              
   "chart") python DAVIDenrich.py $data ;;
esac
cd /nfs/home/students/chit/Thesis/thesis_tool
echo Finished running DAVID!
#fi
python david_plot.py $data
echo DAVID table is plotted.

python gene_oxi_repair_clusters.py $data
echo The clusters for oxi and repiar genes is extracted.

Rscript reactomepa.R $data $pcutoff $scale
echo The reactome PA results are plotted.