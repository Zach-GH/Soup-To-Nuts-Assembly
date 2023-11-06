random: randomGame

CC = gcc

randomGame: randomGameMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out
