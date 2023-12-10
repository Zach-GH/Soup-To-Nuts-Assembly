all: inches2Ft

all_cel: CelToFah

all_fah: FahToCel

MYLIBS = libConversions.o libTypes.o
CC = gcc

inches2Ft: inches2FtMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

CelToFah: CelToFahMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

FahToCel: FahToCelMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@
.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out CelToFah FahToCel
