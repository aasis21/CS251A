all: main.o module.o
	gcc main.o module.o -o target_bin
main.o: main.c module.h
	gcc -I . -c main.c
module.o: module.c module.h
	gcc -I . -c module.c
clean:
	rm -rf *.o
	rm target_bin

