suppressMessages(library(AnnotationDbi))
suppressMessages(library(dplyr))
suppressMessages(library(org.Hs.eg.db))
suppressMessages(library(foreach))

arg <- commandArgs()
data <- arg[6]
mydir <- list.files(sprintf("/nfs/home/students/chit/Thesis/results/%s/",data))
num_to_iter <- sum(grepl("highlogenes", mydir)

convertoens <- function(data, i){
    compar = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes%s.txt",data,i))

    ens <- AnnotationDbi::select(org.Hs.eg.db,
                            keys=as.character(compar),
                            keytype="SYMBOL",
                            columns=c("SYMBOL","ENSEMBL"))


    outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens%s.txt", data,i))
    writeLines(ens$ENSEMBL, outfile)
    close(outfile)
}

foreach(i=num_to_iter) %do% convertoens(data,i)