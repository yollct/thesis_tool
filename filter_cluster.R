library(AnnotationDbi)
library(dplyr)
library(tidyr)
library(org.Hs.eg.db)

arg <- commandArgs()
##arg[6] = results folder
##arg[7] = cluster

clusters = read.csv(sprintf("/home/chit/Desktop/Thesis/results/%s/cluster_table.csv", arg[6]))

filterclust_ensm <- function(clust){
  clu <- clusters %>%
    filter(cluster == clust)
  ens <- AnnotationDbi::select(org.Hs.eg.db,
                               keys = as.character(clu$object),
                               keytype = "SYMBOL",
                               columns = "ENSEMBL")
  return(ens %>% na.omit())
}

whatever <- filterclust_ensm(sprintf("Cluster %s", arg[7]))
write.table(whatever$ENSEMBL, sprintf("/home/chit/Desktop/Thesis/results/%s/clust%s.csv",arg[6],arg[7]), row.names = F,
            col.names = F,
            quote = F)