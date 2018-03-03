#!/bin/bash
check_integer(){
        words=`cat "$1" | tr ' ' '\n'`
        arr=$(echo $words)
        local counter=0
        for x in $arr
        do
            if [[ $x =~ ^[+-]?[0-9]+$ ]]
            then
                counter=$(($counter + 1))
            fi
        done
        local __count=$2
        eval $__count="'$counter'"
        return 0
}

function loop() {
    local path_name=$1
    local space=$2
    local __sentence=$3
    local __integer=$4


    if [ -f "$path_name" ]
    then
        local file_sentence=`wc -l "$path_name"`
        file_sentence=${file_sentence%$path_name}
        file_sentence="${file_sentence/%' '/''}"

        check_integer "$path_name" file_int

        eval $__sentence="'$file_sentence'"
        eval $__integer="'$file_int'"
        echo "$space""(F)" ${path_name##*/}-$file_sentence-$file_int
        return 0

    else
        local dir_sentence=0
        local dir_integer=0
        if [ -z "$(ls -A "$path_name")" ]; then
            echo "$space""(D)" ${path_name##*/}-0-0
        else
            for i in "$path_name"/*
            do
                loop "$i" "$space     "  root_sentence root_integer
                dir_sentence=$(($dir_sentence + $root_sentence))
                dir_integer=$(($dir_integer + $root_integer))
            done
            echo "$space""(D)" ${path_name##*/}-$dir_sentence-$dir_integer
        fi
        eval $__sentence="'$dir_sentence'"

        eval $__integer="'$dir_integer'"
        return 0
    fi
}


loop "$PWD" "     " sentences integers
