import pandas as pd
import numpy as np
from reactome2py import analysis
import webbrowser

with open("/home/chit/Desktop/Thesis/results/3.09/clust3.txt", "r") as f:
    c3 = ",".join(f.read().split("\n"))

results=analysis.identifiers(ids=c3)
token = results['summary']['token']


js = analysis.result2json(token, path="/home/chit/Desktop/Thesis/results/3.09/", file="reactome.json",save=False)
print(pd.read_json(js))
