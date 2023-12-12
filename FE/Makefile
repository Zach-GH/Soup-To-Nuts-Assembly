addAverage: userAddAvg

CC = gcc

userAddAvg: addAverageMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
