library(AnnotationDbi)
library(dplyr)
library(org.Hs.eg.db)

arg <- commandArgs()
data <- arg[6]

#clusters = read.csv(sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", data))
compar = read.csv("/home/chit/Desktop/Thesis/results/3.09_comparison/comparison_node_6_66_68_40.csv")

ens <- AnnotationDbi::select(org.Hs.eg.db,
                             keys=as.character(compar$name),
                             keytype="SYMBOL",
                             columns=c("SYMBOL","ENSEMBL"))

final <- inner_join(compar, ens, by=c("name"="SYMBOL"))

write.table(final, sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", data), row.names = F, sep="\t")

