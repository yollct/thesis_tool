suppressMessages(library(tidyverse))
suppressMessages(library(ReactomePA))
suppressMessages(library(AnnotationDbi))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(DESeq2))
library(xtable)

arg <- commandArgs()
data <- arg[6]
scale <- as.numeric(arg[7])


reactomeplots <- function(data,scale){
genes <- readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens.txt",data))
entrez <- AnnotationDbi::select(org.Hs.eg.db,
                                keys = genes,
                                keytype = "ENSEMBL",
                                columns = "ENTREZID")

x <- enrichPathway(gene=entrez$ENTREZID,pvalueCutoff=0.05, readable=T)
emapplot(x)
ggsave(sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_emapplot.pdf",data,data),device = "pdf", scale= scale)
cnetplot(x, categorySize="pvalue")
ggsave(sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_cnetplot.pdf",data,data),device = "pdf",scale = scale)

p <- data.frame(x) %>%
    arrange(desc(Count)) %>%
  dplyr::select(-geneID,-qvalue, -Count, -pvalue, -BgRatio) 
print(xtable(p, type="latex"),file=sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_reactomepa.txt",data,data), include.rownames = FALSE)

}

reactomeplots(data, scale)



