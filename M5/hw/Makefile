all_ft2I: ft2Inches

all_I2ft: inches2Ft

all_cel: celToFah

all_fah: fahToCel

all_ten:
	gcc tenTimes.s -g -o tenTimes; ./tenTimes

all_twos:
	gcc twosComp.s -g -o twosComp; ./twosComp


MYLIBS = libConversions.o libTypes.o
CC = gcc

ft2Inches: ft2InchesMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

inches2Ft: inches2FtMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

celToFah: celToFahMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

fahToCel: fahToCelMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out
