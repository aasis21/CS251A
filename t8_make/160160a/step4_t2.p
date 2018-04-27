#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color


set key samplen 2 spacing 1.5 font ",20"

set xtics font ",10"
set ytics font ",10"
set ylabel font ",20"
set xlabel font ",20"

set xlabel "number of elements"
set ylabel "average execution time over 100 sample"
set autoscale
set ytic auto
set xtic auto

set key bottom right

set output 'graphs/t2.eps'
threads=system("cat threads.txt")
plot for [thread in threads] './input/'.thread.'_t2.txt' using 1:3 with linespoints title "At thread ".thread
