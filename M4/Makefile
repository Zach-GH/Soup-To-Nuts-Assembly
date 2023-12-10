all: printNum printName

printNum: printInt.s
	gcc printInt.s -g -c -o printInt.o
	gcc printInt.o -g -o printInt
	./printInt
printName: inputString.s
	gcc inputString.s -g -c -o inputString.o
	gcc inputString.o -g -o inputString
	./inputString

printNameAndAge: printNameAndNum.s
	gcc printNameAndNum.s -g -c -o printNameAndNum.o
	gcc printNameAndNum.o -g -o printNameAndNum
	./printNameAndNum
clean:
	rm printNameAndNum; rm printNameAndNum.o; 
	rm printInt; rm printInt.o; rm inputString; rm inputString.o
