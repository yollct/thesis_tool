import pandas as pd
import numpy as np
import sys

data = sys.argv[1]
nodes = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/connectivity_node.csv".format(data))

clusters = np.array(nodes['name'])
clustersno = []
for c in clusters:
    a = c.split(" ")
    clustersno.append(a[1])

with open("/home/chit/Desktop/Thesis/results/{}/all_clusters.txt".format(data), "w") as f:
    for d in clustersno:
        f.write(d+'\n')
        

