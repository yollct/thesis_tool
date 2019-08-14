library(AnnotationDbi)
library(dplyr)
library(org.Hs.eg.db)

arg <- commandArgs()
data <- arg[6]

clusters = read.csv(sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", data))

ens <- AnnotationDbi::select(org.Hs.eg.db,
                             keys=as.character(clusters$object),
                             keytype="SYMBOL",
                             columns=c("SYMBOL","ENSEMBL"))

final <- inner_join(clusters, ens, by=c("object"="SYMBOL"))

write.table(final, sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", data), row.names = F, sep="\t")

head(final)