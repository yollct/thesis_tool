#!/bin/bash
# before this:: get all the clusters txt file
# automate combining clusters with connection, and then david enrich


read -p 'Enter the name of the results folder: ' data
read -p 'High log odd data or connect clusters or custom? (h/c/custom/p)' type
read -p "enter the clusters to combine (c1_c2_c3): " combin
read -p 'The job in david (termenrich, chart): ' job


case $type in
    "c")
        IFS=$"\n" read -d " " -r -a all_clusters  < "/nfs/home/students/chit/Thesis/results/$data/all_connect.txt"
    
        for all in $all_clusters
            do  
            if [ -e /nfs/home/students/chit/Thesis/results/$data/clust$all.txt.termClusteringReport.txt ]
            then 
                echo Cluster $all is finished!
                continue
            else 
                python3 combine_cluster.py $data $all
                echo Cluster$all.txt is saved in $data folder.

                python3 txt2csv.py $data $all
                echo Cluster $all_cluster file is converted to txt.

                cd /home/chit/myDAVIDAPI/PythonClient
                case $job in
                    "termenrich") python DAVIDtermenrich.py $data $all ;;              
                    "chart") python DAVIDenrich.py $data $all;;
                esac
                cd /nfs/home/students/chit/Desktop/Thesis/thesis_tool
                echo Finished running Cluster $all.
            fi
            done 
        ;;
    "h")
        IFS= read -d "" -r -a high_log_odd  < "/nfs/home/students/chit/Thesis/results/$data/high_log_odd.txt"
        echo $high_log_odd
        python3 combine_cluster.py $data $high_log_odd
        echo clust_highlog.txt is saved in $data folder.

        cd /nfs/home/students/chit/myDAVIDAPI/PythonClient
        case $job in
            "termenrich") python DAVIDtermenrich.py $data $high_log_odd ;;              
            "chart") python DAVIDenrich.py $data $high_log_odd ;;
        esac
        cd /nfs/home/students/chit/Thesis/thesis_tool
        echo Finished running Cluster $all.
    ;;
    "custom")
        python3 combine_cluster.py $data $combin
        echo clust $combin is saved in $data folder.

        cd /nfs/home/students/chit/myDAVIDAPI/PythonClient
        case $job in
            "termenrich") python DAVIDtermenrich.py $data $combin ;;              
            "chart") python DAVIDenrich.py $data $combin ;;
        esac
        cd /nfs/home/students/chit/Desktop/Thesis/thesis_tool
        echo Finished running Cluster $all.
    ;;
    "p") 
        cd /nfs/home/students/chit/myDAVIDAPI/PythonClient
        case $job in
            "termenrich") python DAVIDtermenrich.py $data "/nfs/home/students/chit/Thesis/results/3.09_comparison/comparison_node_6_66_68_40.txt";;
            "chart") python DAVIDenrich.py $data $comparison;;
        esac
        cd /nfs/home/students/chit/Thesis/thesis_tool
        echo Finished running $comparison.
    ;;
 esac
        