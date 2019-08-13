#! /bin/bash

FOO=`python -c 'from oxi_david import *; print(" ".join(oxi_gene_list()))'`
echo $FOO

