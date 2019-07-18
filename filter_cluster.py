import pandas as pd
import sys
import numpy as np

data= input("Enter the name of the results folder:")
cluster = input("Enter the name of the cluster:")

n16h = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/cluster_table.csv".format(data))
want = n16h['cluster']=="Cluster {}".format(cluster)

filter = n16h[want]
filter.to_csv("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(data,cluster))

print("The cluster is filted and saved as clust{}.csv in {}.".format(cluster, data))
