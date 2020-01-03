suppressMessages(library(tidyverse))
suppressMessages(library(ReactomePA))
suppressMessages(library(AnnotationDbi))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(DESeq2))
library(xtable)

arg <- commandArgs()
data <- arg[6]
file <- arg[7]
pcutoff <- as.numeric(arg[8])
scale <- as.numeric(arg[9])


reactomeplots <- function(data,file,pcutoff,scale){
genes <- readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/%s",data, file))
entrez <- AnnotationDbi::select(org.Hs.eg.db,
                                keys = genes,
                                keytype = "ENSEMBL",
                                columns = "ENTREZID")

x <- enrichPathway(gene=entrez$ENTREZID,pvalueCutoff=pcutoff, readable=T)
emapplot(x)
ggsave(sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_emapplot.pdf",data,file),device = "pdf", scale= scale)
cnetplot(x, categorySize="pvalue")
ggsave(sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_cnetplot.pdf",data,file),device = "pdf",scale = scale)

p <- data.frame(x) %>%
    arrange(desc(as.numeric(Count))) %>%
  dplyr::select(-geneID,-qvalue, -Count, -pvalue, -BgRatio) 
print(xtable(p, type="latex"),file=sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_reactomepa.txt",data,file), include.rownames = FALSE)
write.csv(data.frame(x), sprintf("/nfs/home/students/chit/Thesis/results/%s/%s_reactomepa.csv",data,file))
}


reactomeplots(data, file,  pcutoff, scale=2)