suppressMessages(library(AnnotationDbi))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(org.Hs.eg.db))

arg <- commandArgs()
result <- arg[6]
input <- arg[7]

clusters = read.csv(sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", result))

filterclust_ensm <- function(clust){
  clu <- clusters %>%
    filter(cluster == clust)
  ens <- AnnotationDbi::select(org.Hs.eg.db,
                               keys = as.character(clu$object),
                               keytype = "SYMBOL",
                               columns = "ENSEMBL")
  return(ens %>% na.omit())
}

whatever <- filterclust_ensm(sprintf("Cluster %s", input))
write.table(whatever$ENSEMBL, sprintf("/home/chit/Desktop/Thesis/results/%s/clust%s.csv",result,input), row.names = F,
            col.names = F,
            quote = F)
