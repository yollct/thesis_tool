import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.patches as mpatches
from sklearn.metrics import silhouette_samples, silhouette_score
from gseapy.parser import Biomart
from scipy.stats.stats import pearsonr
import sys
from os import listdir

data = sys.argv[1]
david = pd.read_csv('/nfs/home/students/chit/Thesis/results/{}/highlogenes.txt.termClusteringReport.txt'.format(data))

##check highlogenes.txt
mydir = listdir('/nfs/home/students/chit/Thesis/results/{}/'.format(data))


def david_termenrich(david):
    three = (david['cluster']<3)
    david = david[three]
    w = len(david)
    size = np.array(david['%']*10)
    plt.figure(figsize=(7,w/2))
    
    plt.scatter(david['Pvalue'], david['Term'], label=None, c=np.array(david['enrichmentscore']), cmap='plasma', s=size)
    plt.colorbar(label='Cluster enrichment score')
    plt.gca().invert_yaxis()
    plt.xlabel('P Value')
    plt.ylabel('Term')
    plt.grid()
    
    for gr in [15, 20, 25]:
        plt.scatter([],[],s=gr*10, label=str(gr), c='k')
    plt.legend(scatterpoints=1, frameon=False, title="Gene ratio", labelspacing=1)
   
    plt.title('DAVID functional annotation clustering')
    


if __name__ == "__main__":
    if sum("highlogenes" in m for m in mydir)>1:
        num_to_iter = sum("highlogenes" in m for m in mydir)
        for i in range(num_to_iter):
            david = pd.read_csv('/nfs/home/students/chit/Thesis/results/{}/highlogenes{}.txt.termClusteringReport.txt'.format(data,i))
            plt.savefig('/nfs/home/students/chit/Thesis/results/{}/highlodavid{}.pdf'.format(data,i), dpi=600)
    else: 
        david = pd.read_csv('/nfs/home/students/chit/Thesis/results/{}/highlogenes.txt.termClusteringReport.txt'.format(data,))
        plt.savefig('/nfs/home/students/chit/Thesis/results/{}/highlodavid.pdf'.format(data,), dpi=600)