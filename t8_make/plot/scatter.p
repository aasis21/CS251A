set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",20"

set xtics font ",10"
set ytics font ",10"
set ylabel font ",20"
set xlabel font ",20"

set title "graph for thread I"
set xlabel "number of sample"
set ylabel "time taken"
set ytic auto
set xtic auto
set autoscale x
set autoscale y

set output "thread.eps"
plot 'log.txt' using 2:7 with points
