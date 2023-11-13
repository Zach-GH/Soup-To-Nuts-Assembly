goldenRatio: recursion

MYLIBS = Summation.o

CC = gcc

recursion: recursionMain $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o $(objects) recursion
