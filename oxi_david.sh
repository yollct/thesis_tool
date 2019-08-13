#!/bin/bash
##term enrichment analysis for oxidation/repair related gene
read -p "Enter the name of the results folder: " data

GENELIST=`python -c 'from oxi_david import *; print(",".join(oxi_genelist('$data')))'`
BG=`python -c 'from oxi_david import *; print(",".join(oxi_bg('$data')))'`

cd /home/chit/PythonClient-1.1/PythonClient

python oxi_termdavid.py $data $GENELIST $BG
echo DAVID finished!

cd /home/chit/Desktop/Thesis/thesis_tool

