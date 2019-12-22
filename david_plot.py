import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.patches as mpatches
import sys
from os import listdir
import math

data = sys.argv[1]

def david_termenrich(david, term, data):
    three = (david['cluster']<term)
    david = david[three]
    w = len(david)
    size = np.array(david['%']*10)
    plt.figure()
    
    plt.scatter(-math.log10(david['Pvalue']), david['Term'], label=None, c=np.array(david['enrichmentscore']), cmap='plasma', s=size)
    plt.colorbar(label='Cluster enrichment score')
    plt.gca().invert_yaxis()
    plt.xlabel('-log10(p-value)')
    plt.ylabel('Term')
    plt.grid()
    
    for gr in [15, 20, 25]:
        plt.scatter([],[],s=gr*10, label=str(gr), c='k')
    plt.legend(scatterpoints=1, frameon=False, title="Gene ratio", labelspacing=1)
   
    plt.title('DAVID functional annotation clustering')
    plt.savefig('/nfs/home/students/chit/Thesis/results/{}/{}_highlodavid.pdf'.format(data,data), bbox_inches='tight', height=1000)
    
    
if __name__ == "__main__":
        david = pd.read_csv('/nfs/home/students/chit/Thesis/results/{}/highlogenes_ens.txt.termClusteringReport.txt'.format(data,data), sep="\t")
        david_plot = david_termenrich(david, 4, data)
        