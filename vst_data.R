library(dplyr)
library(tidyr)
library(ggplot2)
library(AnnotationDbi)
library(org.Hs.eg.db)
library(DESeq2)
library(biomaRt)
library(readxl)
library(vsn)

#import data
exp2 <- read_excel("/home/chit/Desktop/Thesis/data/transcriptome/rnaseq_deseq2_vergleiche.xlsx")
trans <- read.table("/home/chit/Desktop/Thesis/data/transcriptome/gene_counts.tsv", sep="\t", header = T)
genecount <- trans %>% 
  separate("Gene.ID_Chr_Strand_Start_End", into=c("gene_id","chr","strand","start","end"), sep="_") 

#filter data
wanted <- exp2 %>%
  filter(Wartezeit=="16h"|Wartezeit=="30min") %>%
  filter(grepl("2014",seqStart))
nme <- paste0("Count",wanted$name)

#filtering of time table & add gene id
time_table <- genecount[nme] 
time_table$gene_id <- genecount$gene_id
time_table$rowsum <- rowSums(time_table[1:12])
table_for_norm <- time_table %>%
  filter(rowsum!=0) %>%
  dplyr::select(-rowsum)

##variance stabilization
gene <- table_for_norm$gene_id
table_for_norm <- table_for_norm %>%
  dplyr::select(-gene_id)
dds <- DESeqDataSetFromMatrix(countData = table_for_norm,
                              colData = wanted,
                              design = ~0 + Bestrahlungsstaerke)
res <- DESeq(dds)

vsd <- vst(dds)
final <- data.frame(gene_id=gene, assays(vsd)[[1]])
write.table(final, "/home/chit/Desktop/Thesis/data/transcriptome/vst_16h_30min.csv", sep="\t")