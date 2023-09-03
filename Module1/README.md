# Soup-To-Nuts-Assembly Module 1
Zachary Meisner 9/3/23

https://github.com/Zach-GH/Soup-To-Nuts-Assembly

# Purpose
The purpose of this application was to create a multi-tool that allowed the execution of multiple different functions pertaining to the basic learning blocks of Assembly Language, Hex/Binary/Integer/ASCII conversion, and the implementation of bitwise logical operators to demonstrate my knowledge of the subject matter, in addition to the ability to use this tool to assist me with future work assignments.

I normally do my best to try to meet Google Code Standards for my coding style, to be more specific, I normally am only concerened that I do not go over the line limit of 80 characters, in addition to removing all tabs and use four spaces instead.

# Navigating the application
I have done my best to name each class file corresponding to the closest utility it has for its functionality.
For example, asciiConverter is used for toUpper, toLower, and converting an ASCII string of characters to an integer value. In addition to this, outputHex corresponds to the intaking of a binary number, and outputting its corresponding hex value, as well as intaking an integer, and writing out that corresponding value.

Everything is run from the main.java file, which calls the mainFrame class, which is only used for the creation and instantiation of each button that ties together with each corresponding function.

I have added a Makefile for ease of use, with the corresponding commands `make clean` which removes *.class and jar files for consistent updating and compilation, and `make run` to compile a jar file and run the application.

Lastly, there is also a command in the case that your jar file does not work for whatever reason which is
`make run_locally` and all this does is compile and run the application without the compression into the jar file.

Due to my lack of ability to foresee that this may have taken me awhile, in addition to everything else I have going on in my life, this project was created in the course of one day, and late into the night prior.

# Assignment
Choose 2 of the following 4 functions and implement those two programs in the language of your choice.  These programs will be graded.  Be sure to follow proper coding style for the language you have chosen, which you should have learned in your introductory class.  The programs should be properly comment them with your name and purpose of the program as a preamble to the file, and what functions are present in the file (refer to the numbers 1-4 below).  If I have to search the files to find this information, you will lose points.  Be sure to document all functions and observe proper rules for naming of variables and indentation in the language of your choice.  You should implement each of these as a function in your program, and call them from a main function in your program.  You should have a single main program that calls the functions you implement.  The functions to implement are the following:

1. A program to implement the toUpper and toLower.  To implement these functions, you must use the bitwise AND (&) and OR (|) operators.  Using addition and subtraction is not acceptable for this assignment.

2. Write a program to take a string representing a binary number, and write out the number in hex.

3. Write a program to take an integer and write its value out in hex.  You cannot use string formatting, but must mask 4 bits at a time and find the value in a table (array) of hex values.

4. Implement a program that converts an ASCII string of characters to an integer value.  You may NOT use any standard libraries to convert the string to integer. You may use libraries for tasks like retrieving each number from the string, etc.