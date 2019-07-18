##combining clusters
import sys
import pandas as pd 
import numpy as np

resf = input("Enter the name of the results folder:")
c1 = input("Enter the first cluster to combine:")
c2 = input("Now enter the second one:")

cluster1 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c1)).read()
cluster2 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(resf,c2)).read()
combine = cluster1 + cluster2

with open('/home/chit/Desktop/Thesis/results/{}/clust{}_{}.csv'.format(resf,c1,c2),"w") as f:
    f.write(combine)
f.close()

print("The combined file is clust{}_{}.csv in {} folder.".format(c1,c2,resf))