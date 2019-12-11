suppressMessages(library(AnnotationDbi))
suppressMessages(library(dplyr))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(foreach))

arg <- commandArgs()
data <- arg[6]
mydir <- list.files(sprintf("/nfs/home/students/chit/Thesis/results/%s/",data))


compar = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes.txt",d))

ens <- AnnotationDbi::select(org.Hs.eg.db,
                            keys=as.character(compar),
                            keytype="SYMBOL",
                            columns=c("SYMBOL","ENSEMBL"))


outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens.txt", d))
writeLines(ens$ENSEMBL, outfile)
close(outfile)
file.remove(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes.txt",d))


