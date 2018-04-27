all:report plot analyse runtest App

report : report.tex app log.txt analyse.txt plot1 plot2 plot3 plot4
	latex report.tex
	dvipdfm report.dvi
	touch report

plot : plot1 plot2 plot3 plot4

plot1: analyse.txt step4_t1.p
	chmod +x step4_t1.sh
	./step4_t1.sh
	touch plot1
plot2: analyse.txt step4_t2.p
	gnuplot step4_t2.p
	touch plot2
plot3: analyse.txt step4_t3.p
	gnuplot step4_t3.p
	touch plot3
plot4: analyse.txt step4_t4.p
	gnuplot step4_t4.p
	touch plot4

analyse: analyse.txt
analyse.txt: log.txt step3_processing.sh generate_avg_for_thread.sh generate_speed_up.sh generate_speed_up_var.sh
	chmod +x step3_processing.sh
	./step3_processing.sh
	touch analyse.txt

runtest:log.txt
log.txt:app params.txt threads.txt step2_log.sh log_for_each.sh
	chmod +x step2_log.sh
	./step2_log.sh
	touch log.txt

App: app
app:thread_function.o prog.o
	gcc -o app thread_function.o prog.o -lm -lpthread
prog.o: prog.c common.h
	gcc -I . -c prog.c
thread_function.o: thread_function.c common.h
	gcc -I . -c  thread_function.c


.Phony : clean all


clean:
	rm -rf graphs input log prog app report.dvi report.pdf log.txt analyse.txt report.aux report.log
	rm -rf plot1 plot2 plot3 plot4 report
	rm -rf *.o
