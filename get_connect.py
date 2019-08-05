import pandas as pd
import numpy as np
import sys

## get the connectivity edges from edge table
##p<0.001 

data = input("Enter the name of the results folder: ")

edge = pd.read_csv("/home/chit/Desktop/Thesis/results/{}/connectivity_edge.csv".format(data))

new_edge = edge[(edge['p']<=0.001) & (edge['log-odds'].astype(float)>0.05)]

interact = new_edge[['Cluster 1', 'Cluster 2']]
interact.columns=['c1','c2']

final = pd.DataFrame([interact.c1.str.split().str[1],
             interact.c2.str.split().str[1]]).to_dict('list')

with open("/home/chit/Desktop/Thesis/results/{}/all_connect.txt".format(data), 'w') as file:
    for key, value in final.items():
        file.write(value[0]+'_'+value[1]+'\n')
    file.close()