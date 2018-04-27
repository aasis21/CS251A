#!/bin/bash
params=$(cat params.txt)
threads=$(cat threads.txt)
if [ ! -d "log" ]; then
   mkdir log # Control will enter here if $DIRECTORY doesn't exist.
fi

for param in $params
do
	for thread in $threads
	do
		/bin/bash ./log_for_each.sh $param $thread >  log/$param"_"$thread".txt"
		echo  $param $thread
	done
done
