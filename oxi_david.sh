#!/bin/bash
##term enrichment analysis for oxidation/repair related gene

read -p 'Enter the name of the results folder: ' data

GENELIST=`python -c $data 'from oxi_david import *; import sys; data=sys.argv[1]; print(",".join(oxi_genelist(data)))'`
echo $GENELIST

BG=`python -c $data 'from oxi_david import *; import sys; data=sys.argv[1]; print(",".join(oxi_bg(data)))'`
echo $BG
echo yay?