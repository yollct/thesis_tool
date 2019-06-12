import pandas as pd
import sys
import numpy as np

data=sys.argv[1]
cluster = sys.argv[2]

n16h = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/cluster_table.csv".format(data))
want = n16h['cluster']=="Cluster {}".format(cluster)

filter = n16h[want]
filter.to_csv("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(data,cluster))
