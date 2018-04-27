#!/bin/bash
threads=$(cat threads.txt)
params=$(cat params.txt)
if [ ! -d "input" ]; then
   mkdir input # Control will enter here if $DIRECTORY doesn't exist.
fi

#processing for graph type 1
for thread in $threads
do
    cat log/*_$thread.txt > input/$thread"_t1.txt"
done


#processing for graph type  2
for thread in $threads
do
    /bin/bash ./generate_avg_for_thread.sh $thread >  input/$thread"_t2.txt"
done

#processing for graph type 3
/bin/bash ./generate_speed_up.sh  >  input/t3.txt

#processing for graph type 4
/bin/bash ./generate_speed_up_var.sh >  input/t4.txt
