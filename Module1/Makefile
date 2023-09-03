JAVAC=javac
nutsDir=main/java/com/m1
soupDir=src/${nutsDir}
sources = $(wildcard bin/${soupDir}/*.java)
classes = $(sources:.java=.class)
rootDir=../../../../..

all: soupToNuts

soupToNuts: $(classes)

# Clean the java *.class files
clean:
	rm -rf bin/main; rm bin/*.jar;

%.class: %.java
	$(JAVAC) $<

jar: $(classes)
	cd ${soupDir}; javac -d ${rootDir} *.java; \
	cd ${rootDir}; \
	jar cmvf bin/manifest.MF bin/soupToNuts.jar ${nutsDir}; \
	rm -rf main;

.PHONY: all soupToNuts clean jar

# Run Soup to Nuts
run:
	make jar; java -cp bin/soupToNuts.jar main.java.com.m1.main

run_local:
	cd ${soupDir}; javac -d ${rootDir}/bin *.java; \
	cd ${rootDir}/bin; \
	java main.java.com.m1.main main;
	