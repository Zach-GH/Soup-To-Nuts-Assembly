
branch: branching

loop: loopy

#MYLIBS = libConversions.o libTypes.o

CC = gcc

branching: branchingMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

loopy: loopyMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@
.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out
