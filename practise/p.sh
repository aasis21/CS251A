#!/bin/bash
awk -F":"  '
BEGIN {
print "==================================================="
printf "%-8s %5s %7s %10s %10s\n","User","UID","GID","Home", "Shell"
print "==================================================="
}

NR==1,NR==10{ printf "%-8s %5d %7d %10s %10s\n",$1,$3,$4,"sdsd","ssd" }' /etc/passwd
