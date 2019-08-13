import pandas as pd
import numpy as np



oxi_gene = pd.read_excel("/home/chit/Desktop/Thesis/data/4timepoints/GeneListed_Oxi_Repair.xlsx")
clusters = pd.read_csv("/home/chit/Desktop/Thesis/results/05.08/cluster_table.csv", sep="\t")

with open("/home/chit/Desktop/Thesis/results/05.08/all_connect.txt") as f:
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

def oxi_genelist():
    gene_list = highlogodd[highlogodd['object'].isin(oxi_gene['ID'])].ENSEMBL.to_list()
    return(gene_list)

def oxi_bg():
    bg = highlogodd.ENSEMBL.to_list()
    return(bg)
