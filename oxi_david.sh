#!/bin/bash

GENELIST=`python -c 'from oxi_david import *; print(" ".join(oxi_genelist()))'`
echo $GENELIST

BG=`python -c 'from oxi_david import *; print(" ".join(oxi_bg()))'`
echo $BG