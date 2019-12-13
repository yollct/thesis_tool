import pandas as pd
import numpy as np
import sys

## get the connectivity edges from edge table
##p<0.001 

data=sys.argv[1]
pvalue = float(sys.argv[2])

def get_edges(data, High_log_odd=True):
    edge = pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/connectivity_edge.csv".format(data))

    if High_log_odd==True:
        new_edge = edge[(edge['p']<=pvalue) & (edge['log-odds'].astype(float)>0.)]
    else:
        new_edge = edge[(edge['p']<=pvalue)]
    return(new_edge)
    

def connectivity_cluster(data, edges, high=True):
    nodes = pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/cluster_table.csv".format(data))
    interact = edges[['Cluster 1', 'Cluster 2']]
    interact.columns=['c1','c2']

    final = pd.DataFrame([interact.c1.str.split().str[1],
                interact.c2.str.split().str[1]]).to_dict('list')

    highlo=[]
    for u,v in final.items():
        highlo.append(v[0])
        highlo.append(v[1])

    highlogodd = list(set(highlo))

    if high==True:
        with open("/nfs/home/students/chit/Thesis/results/{}/high_log_odd.txt".format(data), "w") as f:
            for x in highlogodd:
                f.write(x+'_')
            f.close()
    else:
        with open("/nfs/home/students/chit/Thesis/results/{}/all_connect.txt".format(data), "w") as f:
            for x in highlogodd:
                f.write(x+'_')
        f.close()

def get_all_clusters(data):
##get all clusters
    clusters = np.unique(nodes['cluster'])
    clustersno = []
    for c in clusters:
        a = c.split(" ")
        clustersno.append(a[1])

    with open("/nfs/home/students/chit/Thesis/results/{}/all_clusters.txt".format(data), "w") as f:
        for d in clustersno:
            f.write(d+'\n')
    f.close()

if __name__ == "__main__":
    high_edge = get_edges(data, High_log_odd=True)
    all_edges = get_edges(data, High_log_odd=False)
    connectivity_cluster(data, high_edge, high=True)
    connectivity_cluster(data, all_edges, high=False)
    get_all_clusters(data)
