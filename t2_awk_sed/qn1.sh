#!/bin/bash
sstrings=0
comments=0
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

ct=`find "$1" -name '*.c' | wc -l`
l_ct=0;
find "$1" -name '*.c' | while read  line; do
      a=`awk -f $2 $line`
      st_ct=`echo $a | cut -d" " -f1`
      cm_ct=`echo $a | cut -d" " -f2`

      strings=$((strings+st_ct ))
      comments=$((comments+cm_ct ))

      l_ct=$((l_ct+1))

      if [ $l_ct -eq $ct ]
      then
          echo "Comments:"$comments "Strings:"$strings
      fi

  done
