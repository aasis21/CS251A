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

set output "graphs/t4.eps"
set key invert reverse right outside
set terminal postscript eps enhanced color size 3.9,2.9
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram

plot 'input/t4.txt' u 2:7:xticlabels(1) title "thread1",\
'' u 3:8 title "thread2" fillstyle pattern 7,\
'' u 4:9 title "thread4" fillstyle pattern 12,\
'' u 5:10 title "thread8" fillstyle pattern 14,\
'' u 6:11 title "thread16" fillstyle pattern 10
