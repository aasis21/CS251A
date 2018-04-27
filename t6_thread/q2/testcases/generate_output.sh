#!/bin/bash

num_threads=( 1 2 4 8 16 )
if [ "$1" == "--clean" ]; then
    for i in {1..4}; do
        for nt in ${num_threads[@]}; do
            rm t$i/acc_out_student_$nt.txt
        done
    done
    rm q2
    exit 0
fi


for i in {1..4}; do
    no_of_transactions=`wc -l t$i/txn.txt`   #60000
    echo $no_of_transactions
    for nt in ${num_threads[@]}; do
        echo "nt = " $nt
        ./q2 "t$i/acc_in.txt" "t$i/txn.txt" "$no_of_transactions" "$nt" > t$i/acc_out_student_$nt.txt
    done
done
