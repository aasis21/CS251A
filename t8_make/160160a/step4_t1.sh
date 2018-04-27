#!/bin/bash
threads=$(cat threads.txt)
if [ ! -d "graphs" ]; then
   mkdir graphs # Control will enter here if $DIRECTORY doesn't exist.
fi
for thread in $threads
do
    inputf="input/"$thread"_t1.txt"
    outputf="graphs/"$thread"_t1.eps"
    echo $inputf
    echo $outputf
    gnuplot -e "output_file='$outputf';input_file='$inputf'" step4_t1.p
done
