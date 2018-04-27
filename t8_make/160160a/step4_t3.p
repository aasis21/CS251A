#set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5

set key font ",12"
set xtics font ",12"
set ytics font ",12"
set ylabel font ",18"
set xlabel font ",18"
set xlabel "number of elements"
set ylabel "Application speedup"
set autoscale
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border

set key invert reverse right outside
set terminal postscript eps enhanced color size 3.9,2.9

set output 'graphs/t3.eps'
plot 'input/t3.txt' u 2:xticlabels(1) title "t1",\
'' u 3 title "thread2" fillstyle pattern 7,\
'' u 4 title "thread4" fillstyle pattern 12,\
'' u 5 title "thread8" fillstyle pattern 14,\
'' u 6 title "thread16" fillstyle pattern 10
