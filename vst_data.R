library(dplyr)
library(tidyr)
library(ggplot2)
library(AnnotationDbi)
library(org.Hs.eg.db)
library(DESeq2)
library(biomaRt)
library(readxl)


# #import data
# exp2 <- read_excel("/home/chit/Desktop/Thesis/data/transcriptome/rnaseq_deseq2_vergleiche.xlsx")
# trans <- read.csv("/home/chit/Desktop/Thesis/data/transcriptome/gene_counts.tsv", header = T, sep = "\t")
# genecount <- trans %>% 
#   separate("Gene.ID_Chr_Strand_Start_End", into=c("gene_id","chr","strand","start","end"), sep="_") 
# 
# #filter data for 2014 datasets
# wanted <- exp2 %>%
#    filter(Wartezeit=="16h"|Wartezeit=="30min") %>%
#    filter(grepl("2014",seqStart))
# nme <- paste0("Count",wanted$name)
# 
# 
# #filtering of time table & add gene id
# time_table <- genecount[nme,] 
# time_table$gene_id <- genecount$gene_id
# time_table$rowsum <- rowSums(time_table[1:12])
# table_for_norm <- time_table %>%
#   filter(rowsum!=0) %>%
#   dplyr::select(-rowsum)
# 
# ##variance stabilization
# gene <- table_for_norm$gene_id
# table_for_norm <- table_for_norm %>%
#   dplyr::select(-gene_id)
# dds <- DESeqDataSetFromMatrix(countData = table_for_norm,
#                               colData = wanted,
#                               design = ~0 + Bestrahlungsstaerke)
# res <- DESeq(dds)
# 
# vsd <- vst(dds)
# final <- data.frame(assays(vsd)[[1]])
# 
# ##filter the 16h & 30min time points
# counts_30min <- paste0("Count",wanted[wanted$Wartezeit=="30min",]$name)
# counts_16h <- paste0("Count",wanted[wanted$Wartezeit=="16h",]$name)
# table_30min <- final[counts_30min]
# table_30min$GENEID <- gene
# table_30min$COMMON <- "30min"
# 
# table_16h <- final[counts_16h]
# table_16h$GENEID <- gene
# table_16h$COMMON <- "16h"
# 
# write.csv(table_30min, "/home/chit/Desktop/Thesis/data/transcriptome/vst_30min.csv", sep="\t", row.names = FALSE)
# write.csv(table_16h, "/home/chit/Desktop/Thesis/data/transcriptome/vst_16h.csv", sep="\t", row.names = FALSE)
# table_30min

###new data
#import data
expnew <- read.csv("/home/chit/Desktop/Thesis/data/4timepoints/condition_table.csv")
#rnanew <- read.csv("/home/chit/Desktop/Thesis/data/transcriptome/4timepoints/genecounts_16h_7d.csv", header = T)
rnanew <- read.csv("/home/chit/Desktop/Thesis/data/4timepoints/new_rna_readcounts.csv")

#filter data for new 16h and 7d
infnew <- expnew %>%
  filter(Wartezeit=="16hr" | Wartezeit=="7days") %>%
  filter(seq=="Next-Seq")
newnme <- infnew$name

new_timetable <- rnanew[, colnames(rnanew) %in% newnme]
new_timetable$GENEID <- rnanew$gene

#filter out not expressed genes
new_timetable$rowsum <- rowSums(new_timetable[1:8])
newer_timetable <- new_timetable %>% 
  filter(rowsum != 0) %>%
  dplyr::select(-rowsum)

#vst 
newgenes <- newer_timetable$GENEID
newer_for_vst <- newer_timetable %>%
  dplyr::select(-GENEID)

dds_new <- DESeqDataSetFromMatrix(countData = newer_for_vst,
                              colData = infnew,
                              design = ~0 + Wartezeit)

res_new <- DESeq(dds_new)
deseq_table <- counts(res_new, normalized=T)
##16hr 7days filter
nme_16hr <- infnew[infnew$Wartezeit=="16hr",]$name
nme_7d <- infnew[infnew$Wartezeit=="7days",]$name
deseq_16hr <- deseq_table[,colnames(deseq_table) %in% nme_16hr]
deseq_7d <- deseq_table[,colnames(deseq_table) %in% nme_7d]

#columns
final_16h <- data.frame(Symbol=newer_timetable$GENEID, deseq_16hr)
final_7d <- data.frame(Symbol=newer_timetable$GENEID, deseq_7d)

#vsd_new <- rlog(dds_new)
#final_new <- assays(vsd_new)[[1]]
#final_final <- data.frame(GENEID=newgenes, COMMON="16h", final_new)

##non-rawdata


#save
#write.csv(final_16h, "/home/chit/Desktop/Thesis/data/4timepoints/id_norm_16h_nexseq1.csv", row.names = F)
#write.csv(final_7d, "/home/chit/Desktop/Thesis/data/4timepoints/id_norm_7d_nexseq1.csv", row.names = F)
