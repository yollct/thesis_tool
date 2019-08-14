#!/bin/bash
##term enrichment analysis for oxidation/repair related gene
read -p "Enter the name of the results folder: " data

python oxi_david.py $data

cd /data/home/students/chit/myDAVIDAPI/PythonClient

python oxi_termdavid.py $data 
echo DAVID finished!

cd /data/home/students/chit/Thesis/thesis_tool

