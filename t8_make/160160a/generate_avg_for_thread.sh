#!/bin/bash
params=$(cat params.txt)
thread=$1
for param in $params
do
    average=$(cat log/$param"_"$thread".txt" | awk '{ sum += $4 } END { if (NR > 0) print sum / NR }')
    echo  $param $thread $average
done
