#!/bin/bash
threads=$(cat threads.txt)
params=$(cat params.txt)
line_to_append="#param "
for thread in $threads
do
    line_to_append=$line_to_append"thread$thread "
done
echo $line_to_append
for param in $params
do
    line_to_append="$param "
    average_one=average=$(cat log/$param"_1.txt" | awk '{ sum += $4 } END { if (NR > 0) print sum / NR }')
    for thread in $threads
    do
        average=$(cat log/$param"_"$thread".txt" | awk '{ sum += $4 } END { if (NR > 0) print sum / NR }')
        speedup=$(awk "BEGIN {print $average_one/$average}")
        line_to_append=$line_to_append" $speedup"
    done
    echo $line_to_append
done
