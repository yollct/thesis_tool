suppressMessages(library(tidyverse))
suppressMessages(library(ReactomePA))
suppressMessages(library(AnnotationDbi))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(DESeq2))

arg <- commandArgs()
data <- arg[6]

reactomeplots <- function(data){
genes <- readLines(sprintf("/home/chit/Desktop/Thesis/results/%s/highlogenes_ens.txt",data))
entrez <- AnnotationDbi::select(org.Hs.eg.db,
                                keys = genes,
                                keytype = "ENSEMBL",
                                columns = "ENTREZID")

x <- enrichPathway(gene=entrez$ENTREZID,pvalueCutoff=0.05, readable=T)
emapplot(x)
ggsave(sprintf("/home/chit/Desktop/Thesis/maintext/figures/%s_emapplot.pdf",data),device = "pdf",scale = 2)
cnetplot(x, categorySize="pvalue")
ggsave(sprintf("/home/chit/Desktop/Thesis/maintext/figures/%s_cnetplot.pdf",data),device = "pdf",scale = 2)
}

reactomeplots(data)

