import pandas as pd
import numpy as np
import sys


def oxi_genelist(data):
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
    bg = highlogodd.ENSEMBL.to_list()
    return(bg)

if __name__ == "__main__":
    oxi_genelist(data)
    oxi_bg(data)
    
