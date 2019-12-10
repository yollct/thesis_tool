library(AnnotationDbi)
library(dplyr)
library(org.Hs.eg.db)

arg <- commandArgs()
data <- arg[6]

#clusters = read.csv(sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", data))
compar = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes.txt",data))

ens <- AnnotationDbi::select(org.Hs.eg.db,
                             keys=as.character(compar),
                             keytype="SYMBOL",
                             columns=c("SYMBOL","ENSEMBL"))


outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens.txt", data))
writeLines(ens$ENSEMBL, outfile)
close(outfile)
