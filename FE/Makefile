addAvg: addAverage

CC = gcc

addAverage: addAverageMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
