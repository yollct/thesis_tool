import pandas as pd
import numpy as np
import sys

data = sys.argv[1]
nodes = pd.read_csv("/data/home/students/chit/Thesis/results/{}/node_table.csv".format(data))

clusters = np.array(nodes['name'])
clustersno = []
for c in clusters:
    a = c.split(" ")
    clustersno.append(a[1])

with open("/data/home/students/chit/Thesis/results/{}/all_clusters.txt".format(data), "w") as f:
    for d in clustersno:
        f.write(d+'\n')
