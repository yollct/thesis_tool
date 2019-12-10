##combining clusters
import sys
import pandas as pd 
import numpy as np

data = sys.argv[1]
com = open("/nfs/home/students/chit/Thesis/results/{}/high_log_odd.txt".format(data)).read()
cluster_table = pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/cluster_table.csv".format(data))
clusters = com.split('_')

hlo_genes = []

for x in clusters:
    cluster = "Cluster "+ x
    get_genes = cluster_table.loc[[cluster_table['Cluster']==cluster]]
    hlo_genes.append(get_genes['object'])


with open('/nfs/home/students/chit/Thesis/results/{}/highlogenes.txt'.format(data),"w") as f:
    for i in hlo_genes:
        f.write(i+"\n")
f.close()

print("The high log genes are saved in {} folder.".format(data))
