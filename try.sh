#! /bin/bash

FOO = `python -c 'from oxi_david import *; print " ".join(oxi_gene_list())'`
for x in $FOO:
do
        echo "This is foo.sh: $x"
done

