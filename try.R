arg <- commandArgs()
input <- strsplit(arg[6], ",")

for (i in input){
    print(i)
}
