import pandas as pd
import numpy as np
import sys

data=sys.argv[1]

def gene_oxi_cluster(data):
    raw=pd.ExcelFile("/nfs/home/students/chit/Thesis/data/4timepoints/GeneListed_Oxi_Repair.xlsx")
    raw.sheet_names
    geneoxi = raw.parse('Oxidative Stress')
    generepair = raw.parse('Repair Mechanism')

    gene_oxi = geneoxi['ID'].to_list()
    gene_repair = generepair['Gen'].to_list()

    n16_ns=pd.read_csv("/nfs/home/students/chit/Thesis/results/{}/cluster_table.csv".format(data))
    n16_hloc=open("/nfs/home/students/chit/Thesis/results/{}/high_log_odd.txt".format(data), "r").read()
    n16_hloc = n16_hloc.split('_')[:-1]
    n16_hloc = ['Cluster '+ x for x in n16_hloc]

    gene_oxi_cluster = n16_ns[n16_ns['object'].isin(gene_oxi)]['cluster'].unique()
    gene_repair_cluster = n16_ns[n16_ns['object'].isin(gene_repair)]['cluster'].unique()
    
    hlo_oxi = gene_oxi_cluster[np.isin(gene_oxi_cluster, n16_hloc)].tolist()
    hlo_repair = gene_repair_cluster[np.isin(gene_repair_cluster, n16_hloc)].tolist()
    
    ##write file
    with open("/nfs/home/students/chit/Thesis/results/{}/gene_oxi_repair_clusters.txt".format(data), "w") as f:
        f.write("Gene oxidative stress clusters with green edges: "+"\n")
        f.write("_".join(hlo_oxi)+"\n")
        f.write("Gene repair mechanism clusters with green edges: "+"\n")
        f.write("_".join(hlo_repair)+"\n")

if __name__ == "__main__":
    gene_oxi_cluster(data)    