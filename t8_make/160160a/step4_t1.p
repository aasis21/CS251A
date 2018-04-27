set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",20"

set xtics font ",12"
set ytics font ",12"
set ylabel font ",20"
set xlabel font ",20"

#set format y "10^{%L}"
set xlabel "number of elements"
set ylabel "execution time "
set ytic auto
set xtic auto
set autoscale
set output output_file
plot input_file using 2:4 with points
