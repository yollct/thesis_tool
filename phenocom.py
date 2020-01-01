import pandas as pd
import numpy as np 
import sys
import seaborn as sns
import matplotlib.pyplot as plt


data = sys.argv[1]
n16c1 = str(sys.argv[2])
n7c1 = str(sys.argv[3])
n16c2 = str(sys.argv[4])
n7c2 = str(sys.argv[5])

def jaccard(c, cnorm):
    intersect = list(set(c['object']).intersection(set(cnorm['object'])))
    total = len(c[~c.object.isin(intersect)])+len(cnorm[~cnorm.object.isin(intersect)])+len(intersect)
    jacc = (len(intersect)/total)*100
    return(jacc)

def diffgeneplot(c1,c2, namec1,namec2):
    if data=="ns":
        n16 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n16_ns/cluster_table.csv")
        n7 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n7_ns/cluster_table.csv")
        n16raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/16hr_Next-Seq_deseq2.csv')
        n7raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/7days_Next-Seq_deseq2.csv')
    else:
        n16 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n16_ns1/cluster_table.csv")
        n7 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n7_ns1/cluster_table.csv")
        n16raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/16hr_Next-Seq1_deseq2.csv')
        n7raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/7days_Next-Seq1_deseq2.csv')



    intersect = list(set(c1['object']).intersection(set(c2['object'])))
    n16pc = n16raw[n16raw['SYMBOL'].isin(intersect)]
    n16pc['data']="16hrs"
    n7pc = n7raw[n7raw['SYMBOL'].isin(intersect)]
    n7pc['data']="7days"

    allpc = pd.concat([n16pc,n7pc])
    allpc.columns = ['SYMBOL', 'COMMON','0','0.5','2','10','data']
    long_allpc=pd.melt(allpc, id_vars=['SYMBOL','data'], value_vars=['0','0.5','2','10'])

    plt.subplots(figsize=(12,10))
    ax = sns.lineplot(x="variable",y="value",hue="data",data=long_allpc, sort=False, markers=True)
    ax.set(xlabel="Dosage(Gy)", ylabel="Gene expression", title='Cluster{}_Cluster{}'.format(namec1,namec2))
    plt.savefig("/home/chit/Desktop/Thesis/maintext/figures/{}_diffgenepc_{}_{}.png".format(data, namec1,namec2))
    plt.show()

def phenocom(data, n16c1, n7c1, n16c2, n7c2):
    if data=="ns":
        n16 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n16_ns/cluster_table.csv")
        n7 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n7_ns/cluster_table.csv")
        n16raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/16hr_Next-Seq_deseq2.csv')
        n7raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/7days_Next-Seq_deseq2.csv')
    else:
        n16 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n16_ns1/cluster_table.csv")
        n7 = pd.read_csv("/home/chit/Desktop/Thesis/results/old_n7_ns1/cluster_table.csv")
        n16raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/16hr_Next-Seq1_deseq2.csv')
        n7raw = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/7days_Next-Seq1_deseq2.csv')

    ##to compare
    n16_p1 = n16[n16['cluster']=='Cluster {}'.format(n16c1)]
    n7_p1 = n7[n7['cluster']=='Cluster {}'.format(n7c1)]

    ##to compare
    n16_p2 = n16[n16['cluster']=='Cluster {}'.format(n16c2)]
    n7_p2 = n7[n7['cluster']=='Cluster {}'.format(n7c2)]

    j1 = jaccard(n16_p1, n7_p1)
    j2 = jaccard(n16_p2, n7_p2)
    pairs=["c{}_c{}".format(n16c1,n7c1),"c{}_c{}".format(n16c2,n7c2)]
    jaccs=[j1,j2]

    #sns.set(font_scale=1.5, style="whitegrid")

    #plt.subplots(figsize=(13,10))
    #ax = sns.barplot(y=pairs, x=jaccs, palette="husl")
    #ax.set_xlabel("Jaccard index (%)")
    #ax.set_ylabel("Cluster pairs")
    #ax.set_xlim([0,20])

    #plt.savefig("/home/chit/Desktop/Thesis/maintext/figures/{}_jaccard_phenocomp_{}_{}.png".format(data, n16c1,n7c1))
    #plt.show()

    #diffgeneplot(n16_p1, n7_p1, n16c1, n7c1)
    #diffgeneplot(n16_p2, n7_p2, n16c2, n7c2)

    print(jaccs)

if __name__ == "__main__":
    phenocom(data, n16c1, n7c1, n16c2, n7c2)
    