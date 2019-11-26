##combining clusters
import sys
import pandas as pd 
import numpy as np

resf = sys.argv[1]
com = sys.argv[2]

if len(com.split('_'))==2:

    c1 = com.split('_')[0]
    c2 = com.split('_')[1]

    cluster1 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.txt".format(resf,c1)).read()
    cluster2 = open("/home/chit/Desktop/Thesis/results/{}/clust{}.txt".format(resf,c2)).read()
    combine = cluster1 + cluster2

    with open('/home/chit/Desktop/Thesis/results/{}/clust{}_{}.txt'.format(resf,c1,c2),"w") as f:
        f.write(combine)
    f.close()

    print("The combined file is clust{}_{}.csv in {} folder.".format(c1,c2,resf))
else:
    cc = com.split("_")
    ##del the last empty value of the list
    del cc[-1]

    dfs=[]
    for i in cc:
        dfs.append(pd.read_csv("/home/chit/Desktop/Thesis/results/{}/clust{}.txt".format(resf,i),header=None))
    
    highlogfinal = pd.concat(dfs)

    highlogfinal.to_csv("/home/chit/Desktop/Thesis/results/{}/clust{}.txt".format(resf, com),sep="\t",index=False, header=None)