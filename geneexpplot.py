import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

gene = sys.argv[1]

##raw norm data
def geneplot(gene):
    n16h = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/16hr_Next-Seq1_deseq2.csv')
    n7d = pd.read_csv('/home/chit/Desktop/Thesis/data/4timepoints/7days_Next-Seq1_deseq2.csv')

    com = pd.DataFrame(np.vstack([n16h[n16h['SYMBOL']==gene].iloc[:,2:].values,n7d[n7d['SYMBOL']==gene].iloc[:,2:].values])).T
    com.columns = ['16h','7d']
    com['dosage'] = ['0g','2g','5g','10g']
    com=com.set_index('dosage')
    com.plot()
    plt.title("Expression of "+gene)
    plt.xlabel("Dosage")
    #plt.savefig('/home/chit/Desktop/Thesis/maintext/figures/{}.png'.format(gene), bbox_inches='tight', height=1000)
    plt.show()

if __name__ == "__main__":
    geneplot(gene)   