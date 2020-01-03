suppressMessages(library(AnnotationDbi))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(org.Hs.eg.db))

arg <- commandArgs()
result <- arg[6]
input <- arg[7]

clusters = read.csv(sprintf("/nfs/home/students/chit/Thesis/results/%s/cluster_table.csv",result))

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
writeLines(whatever$ENSEMBL, sprintf("/nfs/home/students/chit/Thesis/results/%s/clust%s.txt",result,input))



