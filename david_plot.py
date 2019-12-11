import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.patches as mpatches
import sys
from os import listdir

data = sys.argv[1]



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
        david = pd.read_csv('/nfs/home/students/chit/Thesis/results/{}/highlogenes_ens.txt.termClusteringReport.txt'.format(data)sep="\t", header=True)
        plt.savefig('/nfs/home/students/chit/Thesis/results/{}/highlodavid.pdf'.format(data), dpi=600)
        plt.show()