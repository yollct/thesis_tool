from reactome2py import analysis
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

data = sys.argv[1]
#file
with open("/nfs/home/students/chit/Thesis/results/{}/highlogenes_ens.txt".format(data), "r") as f:
    genes = ",".join(f.read().split("\n"))

results = analysis.identifiers(ids=genes)
token=results['summary']['token']

js= analysis.result2json(token, path="/nfs/home/students/chit/Thesis/results/{}/".format(data), file="reactome.json",save=False)

reactome = []
fdr=[]
count=[]
pvalue=[]
for i in range(len(js['pathways'])):
    if js['pathways'][i]['data']['statistics'][0]['entitiesPValue']<0.01:
        reactome.append(js['pathways'][i]['name'])
        fdr.append(js['pathways'][i]['data']['statistics'][0]['entitiesFDR'])
        count.append(js['pathways'][i]['data']['statistics'][0]['entitiesFound'])
        pvalue.append(js['pathways'][i]['data']['statistics'][0]['entitiesPValue'])
    else:
        continue

react = pd.DataFrame({'reactome':reactome,
                     'fdr':fdr,
                     'count':count,
                     'pvalue':pvalue})
react = react.sort_values('pvalue', ascending=False)

plt.figure(figsize=[6,9])
size=np.array(count)
color=np.array(react['fdr'])

plt.grid()
plt.scatter(react['pvalue'], react['reactome'],s=size*5, c=color,cmap="winter")
plt.xlabel("P-value")
plt.colorbar(label="FDR")
plt.title("Reactome pathways")
plt.xticks(size=10)
plt.yticks(size=13)

for gr in [10,25,45]:
    plt.scatter([],[],s=gr*5, label=str(gr), c='k')
plt.legend(scatterpoints=1, frameon=False, title="Gene ratio", labelspacing=1)

plt.savefig('/nfs/home/students/chit/Thesis/results/{}/highloreactome.pdf'.format(data), bbox_inches='tight')
