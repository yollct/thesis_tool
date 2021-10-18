suppressMessages(library(AnnotationDbi))
suppressMessages(library(dplyr))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(foreach))

arg <- commandArgs()
data <- arg[6]
mydir <- list.files(sprintf("/nfs/home/students/chit/Thesis/results/%s/",data))


compar = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes.txt",data))

ens <- AnnotationDbi::select(org.Hs.eg.db,
                            keys=as.character(compar),
                            keytype="SYMBOL",
                            columns=c("SYMBOL","ENSEMBL"))


outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens.txt", data))
writeLines(ens$ENSEMBL, outfile)
close(outfile)
file.remove(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes.txt",data))

if (length(compar)>3000) {
compard = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_david.txt",data))

ens <- AnnotationDbi::select(org.Hs.eg.db,
                            keys=as.character(compar),
                            keytype="SYMBOL",
                            columns=c("SYMBOL","ENSEMBL"))


outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_daivd_ens.txt", data))
writeLines(ens$ENSEMBL, outfile)
close(outfile)
file.remove(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_david.txt",data))
}
