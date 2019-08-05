import csv
import sys

folder = sys.argv[1]
cluster = sys.argv[2]

with open("/home/chit/Desktop/Thesis/results/{}/clust{}.txt".format(folder,cluster), "w") as my_output_file:
    with open("/home/chit/Desktop/Thesis/results/{}/clust{}.csv".format(folder,cluster), "r") as my_input_file:
        [ my_output_file.write(" ".join(row)+'\n') for row in csv.reader(my_input_file)]
    my_output_file.close()

    
