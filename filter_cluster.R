library(AnnotationDbi)
library(dplyr)
library(tidyr)
library(org.Hs.eg.db)

arg <- commandArgs()
##arg[6] = results folder
##arg[7] = cluster
result <- readline(prompt="Enter the name of the result folder: ")
cluster <- readline(prompt="Enter the cluster number: ")


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

whatever <- filterclust_ensm(sprintf("Cluster %s", cluster))
write.table(whatever$ENSEMBL, sprintf("/home/chit/Desktop/Thesis/results/%s/clust%s.csv",result,cluster), row.names = F,
            col.names = F,
            quote = F)