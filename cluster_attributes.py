import pandas as pd
import numpy as np
import networkx as nx
import matplotlib.pyplot as plt
import sys

data = sys.argv[1]
clusters = []
for i in range(2, len(sys.argv)):
    clusters.append(sys.argv[i])

alles = []
for i in clusters:
    c = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/clust{}.txt.termClusteringReport.txt".format(data, i), sep="\t")
    
    #convert terms into dict for each cluster report
    cols = ['mainTerm','enrichmentscore']
    cluster_term = []
    for j in c['cluster'].unique():
        term = c[c['cluster']==j]
        termdata = (term['Term'].iloc[0], term['enrichmentscore'].iloc[0])
        cluster_term.append(termdata)
    
    d = pd.DataFrame(cluster_term, columns=cols).groupby('mainTerm')[['enrichmentscore']].max().T
    d.name = 'Cluster {}'.format(i)
    d['Cluster'] = 'Cluster {}'.format(i)
    alles.append(d)

    #final data frame of all terms for all clusters
final = alles[0]
for i in range(1,len(alles)):
    final = final.merge(alles[i], how='outer')
final_dict = final.set_index('Cluster').to_dict('index')

#edge1 = edge[['Cluster 1', 'Cluster 2']]
ori = nx.read_graphml("/home/chit/Desktop/Thesis/results/{}/connectivity.graphml".format(data))

#create graph and position
mapping = {node[0] : node[1]['name'] for node in ori.nodes(data=True)}
G = nx.relabel_nodes(ori, mapping)

nx.set_node_attributes(G, final_dict)

nx.write_graphml(G, "/home/chit/Desktop/Thesis/results/{}/terms_connectivity.graphml".format(data))