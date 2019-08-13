#!/bin/bash
##term enrichment analysis for oxidation/repair related gene

read -p 'Enter the name of the results folder: ' data

GENELIST=`python 'from oxi_david import *; print(",".join(oxi_genelist()))'`
echo $GENELIST

BG=`python 'from oxi_david import *; print(",".join(oxi_bg()))'`
echo $BG