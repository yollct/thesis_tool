#!/bin/bash


read -p 'Enter the name of the results folder: ' data
read -p 'Enter the name of the cluster file(.txt): ' cluster
read -p "Enter the DAVID analysis (termenrich/chart): " job

cd /home/chit/PythonClient-1.1/PythonClient
case $job in
    "termenrich") python DAVIDtermenrich.py $data $cluster ;;              
    "chart") python DAVIDenrich.py $data $cluster ;;
esac
cd /home/chit/Desktop/Thesis/thesis_tool
echo Finished!