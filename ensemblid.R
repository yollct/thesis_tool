library(AnnotationDbi)
library(dplyr)
library(org.Hs.eg.db)

clusters = read.csv("/data/home/students/chit/Thesis/results/05.08/cluster_table.csv")

ens <- AnnotationDbi::select(org.Hs.eg.db,
                             keys=as.character(clusters$object),
                             keytype="SYMBOL",
                             columns=c("SYMBOL","ENSEMBL"))

final <- inner_join(clusters, ens, by=c("object"="SYMBOL"))

write.table(final, "/data/home/students/chit/Thesis/results/05.08/cluster_table.csv", row.names = F, sep="\t")

head(final)