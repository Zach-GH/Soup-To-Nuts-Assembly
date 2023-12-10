
char: checkChar

grade: checkGrade

find: findLargest

#MYLIBS = libConversions.o libTypes.o

CC = gcc

checkChar: checkCharMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

checkGrade: checkGradeMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

findLargest: findLargestMain.o
	$(CC) $@Main.o -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out
