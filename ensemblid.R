library(AnnotationDbi)
library(dplyr)
library(org.Hs.eg.db)

arg <- commandArgs()
data <- arg[6]
mydir <- list.files(sprintf("/nfs/home/students/chit/Thesis/results/%s/",data))
num_to_iter <- sum(grepl("highlogenes", mydir)
for (i in 1:num_to_iter){
    compar = readLines(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes%s.txt",data,i))

    ens <- AnnotationDbi::select(org.Hs.eg.db,
                            keys=as.character(compar),
                            keytype="SYMBOL",
                            columns=c("SYMBOL","ENSEMBL"))


    outfile <- file(sprintf("/nfs/home/students/chit/Thesis/results/%s/highlogenes_ens%s.txt", data,i))
    writeLines(ens$ENSEMBL, outfile)
    close(outfile)
}
