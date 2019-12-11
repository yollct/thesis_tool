##combining clusters
import sys
import pandas as pd 
import numpy as np
import random

data = sys.argv[1]
com = open("/nfs/home/students/chit/Thesis/results/{}/high_log_odd.txt".format(data)).read()
cluster_table = pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/cluster_table.csv".format(data))
clusters = com.split('_')

hlo_genes = []

for x in clusters:
    cluster = "Cluster "+ x
    get_genes = cluster_table.loc[cluster_table.cluster=="Cluster 82"]['object'].to_list()
    for y in get_genes:
        hlo_genes.append(y)

if len(hlo_genes)>3000:
        random_genes = random.sample(hlo_genes, 2999)
        with open('/nfs/home/students/chit/Thesis/results/{}/highlogenes_david.txt'.format(data,j),"w") as f:
            for i in random_genes:
                f.write(i+"\n")
        f.close()

with open('/nfs/home/students/chit/Thesis/results/{}/highlogenes.txt'.format(data),"w") as f:
    for i in hlo_genes:
        f.write(i+"\n")
f.close()

