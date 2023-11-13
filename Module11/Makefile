gold: recursion

sum: Summation

CC = gcc

recursion: recursionMain.o
	$(CC) $@Main.o  -Wall -g -o $@
	./$@

Summation: SummationMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o $(objects) recursionMain Summation
