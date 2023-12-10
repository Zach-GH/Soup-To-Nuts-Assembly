all_feet: CtoF

all_inches: ItoF

all_cel: CelToFah

all_fah: FahToCel

all_miles: miles2kilometers

only_one: oneFileToRuleThemAll

MYLIBS = libConversions.o libTypes.o

CC = gcc

CtoF: CtoFMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

ItoF: ItoFMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

CelToFah: CelToFahMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

FahToCel: FahToCelMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

miles2kilometers: miles2kilometersMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -g -o $@
	./$@

oneFileToRuleThemAll: oneFileToRuleThemAllMain.o $(MYLIBS)
	$(CC) $@Main.o $(MYLIBS) -Wall -g -o $@
	./$@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@

clean:
	rm *.o a.out
