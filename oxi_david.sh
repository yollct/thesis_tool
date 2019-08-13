#!/bin/bash
##term enrichment analysis for oxidation/repair related gene
read -p "Enter the name of the results folder: " data

python oxi_david.py $data

cd /home/chit/PythonClient-1.1/PythonClient

python3.6 oxi_termdavid.py $data 
echo DAVID finished!

cd /home/chit/Desktop/Thesis/thesis_tool

