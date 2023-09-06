#! /bin/bash

directory="/home/julie/AdminSys/Scriptes/Linux/TP_ENI/Exercices/msp"

lists=$(cat ${directory}/test.txt)

IFS="\n"

for list in $lists
do
    echo "ligne : ${list}"
    echo ${list} >> "${directory}/new.txt"
done

set | grep ^IFS