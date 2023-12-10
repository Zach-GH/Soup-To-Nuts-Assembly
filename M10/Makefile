game: randomGame

MYLIBS = RandFunc.o

CC = gcc

randomGame: randomGameMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o $(objects) randomGame
