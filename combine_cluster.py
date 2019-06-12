##combining clusters
import sys
import pandas as pd 
import numpy as np

resf = sys.argv[1]
c1 = sys.argv[2]
c2 = sys.argv[3]

cluster1 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c1)).read()
cluster2 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c2)).read()
combine = cluster1 + cluster2

with open('/home/chit/Desktop/Thesis/results/{}/clust{}_{}.csv'.format(resf,c1,c2),"w") as f:
    f.write(combine)