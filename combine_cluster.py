##combining clusters
import sys
import pandas as pd 
import numpy as np

resf = sys.argv[1]
com = sys.argv[2]

c1 = com.split('_')[0]
c2 = com.split('_')[1]

cluster1 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c1)).read()
cluster2 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c2)).read()
combine = cluster1 + cluster2

with open('/home/chit/Desktop/Thesis/results/{}/clust{}_{}.csv'.format(resf,c1,c2),"w") as f:
    f.write(combine)
f.close()

print("The combined file is clust{}_{}.csv in {} folder.".format(c1,c2,resf))