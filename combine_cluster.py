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
    if len(hlo_genes)>3000:
        num_to_pick = len(hlo_genes)//3000
        for j in range(num_to_pick):
            random_genes = random.sample(hlo_genes, 2999)
            with open('/nfs/home/students/chit/Thesis/results/{}/highlogenes{}.txt'.format(data,j+1),"w") as f:
                for i in random_genes:
                    f.write(i+"\n")
            f.close()
    else:
        with open('/nfs/home/students/chit/Thesis/results/{}/highlogenes1.txt'.format(data,),"w") as f:
                for i in hlo_genes:
                    f.write(i+"\n")
        f.close()

print("The high log genes are saved in {} folder.".format(data))
