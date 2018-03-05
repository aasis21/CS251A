#!/bin/bash
xml_file=$1
function trim {
    echo $* | xargs
}
cmd=0
IFS=$'\n'
for line in $(cat $xml_file|tr '<|>' '\n'); 
do
    my_line=$(trim $line)
    my_line=$(trim $my_line)
    
    if [[ $my_line ]]; then
            echo $my_line
	    if [[ $my_line == 'dir' ]];
	    then
		cmd=1
	    elif [[ $my_line == 'name' ]] && [[ $cmd == 1 ]];
	    then
		cmd=2
	    elif [[ $cmd == 2 ]];
	    then
		mkdir "$my_line"
		cd $my_line
		cmd=1
	    elif [[ $my_line == '/name' ]];
	    then
		cmd=1
	    elif [[ $my_line == '/dir' ]];
	    then
		cd ..
	    fi

	    if [[ $my_line == 'file' ]];
	    then
		cmd=3
	    elif [[ $my_line == 'name' ]] && [[ $cmd == 3 ]];
	    then
		cmd=4
	    elif [[ $cmd == 4 ]];
	    then
		cur_file=$my_line
		cmd=3
	    elif [[ $my_line == 'size' ]];
	    then 
		cmd=5
	    elif [[ $cmd == 5 ]];
	    then 
	    	touch "$cur_file"
		truncate -s $my_line "$cur_file"
		cmd=3
	    fi
    fi
    
 
done


