import pandas as pd
import numpy as np
import sys

""" def oxi_genelist(data):
    oxi_gene = pd.read_excel("/home/chit/Desktop/Thesis/data/4timepoints/GeneListed_Oxi_Repair.xlsx")
    clusters = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/cluster_table.csv".format(data), sep="\t")

    with open("/home/chit/Desktop/Thesis/results/{}/all_connect.txt".format(data)) as f:
        connect = f.read().split("\n")

    logodd_cluster = []
    for a in connect:
        split = a.split("_")
        for b in split:
            c = "Cluster "+ b
            if c not in logodd_cluster:
                logodd_cluster.append(c)


    ##filter the clusters and oxi gene list
    highlogodd = clusters[clusters['cluster'].isin(logodd_cluster)].dropna()
    gene_list = highlogodd[highlogodd['object'].isin(oxi_gene['ID'])].ENSEMBL.to_list()
    return(gene_list)

def oxi_bg(data):
    clusters = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/cluster_table.csv".format(data), sep="\t")

    with open("/home/chit/Desktop/Thesis/results/{}/all_connect.txt".format(data)) as f:
        connect = f.read().split("\n")

    logodd_cluster = []
    for a in connect:
        split = a.split("_")
        for b in split:
            c = "Cluster "+ b
            if c not in logodd_cluster:
                logodd_cluster.append(c)


    ##filter the clusters and oxi gene list
    highlogodd = clusters[clusters['cluster'].isin(logodd_cluster)].dropna()
    bg = highlogodd.ENSEMBL.to_list()
    return(bg) """

data=sys.argv[1]

oxi_gene = pd.read_excel("/nfs/home/students/chit/Thesis/data/4timepoints/GeneListed_Oxi_Repair.xlsx")
clusters = pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/cluster_table.csv".format(data), sep="\t")

with open("/nfs/home/students/chit/Thesis/results/{}/all_connect.txt".format(data)) as f:
    connect = f.read().split("\n")

logodd_cluster = []
for a in connect:
    split = a.split("_")
    for b in split:
        c = "Cluster "+ b
        if c not in logodd_cluster:
            logodd_cluster.append(c)


##filter the clusters and oxi gene list
highlogodd = clusters[clusters['cluster'].isin(logodd_cluster)].dropna()
gene_list = highlogodd[highlogodd['object'].isin(oxi_gene['ID'])].ENSEMBL.to_list()
bg = highlogodd.ENSEMBL.to_list()

with open("/nfs/home/students/chit/Thesis/results/{}/oxi_genelist.txt".format(data), "w") as genelist:
    for a in gene_list:
        genelist.write(a+"\n")

with open("/nfs/home/students/chit/Thesis/results/{}/oxi_bg.txt".format(data), "w") as bgg:
    for b in bg:
        bgg.write(b+"\n")
