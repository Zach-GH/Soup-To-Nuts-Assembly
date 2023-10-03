time: CalcTime.s
	gcc CalcTime.s -g -c -o CalcTime.o
	gcc CalcTime.o -g -o CalcTime

cel2Fah: CelToFah.s
	gcc CelToFah.s -g -c -o CelToFah.o
	gcc CelToFah.o -g -o CelToFah
	./CelToFah

addval: AddValue.s
	gcc AddValue.s -g -c -o AddValue.o
	gcc AddValue.o -g -o AddValue
	./AddValue
clean:
	rm *.o; rm CalcTime; rm CelToFah; rm AddValue;

