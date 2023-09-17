# Soup-To-Nuts-Assembly Module 3
Zachary Meisner 9/17/23

https://github.com/Zach-GH/Soup-To-Nuts-Assembly

Sections 3.1.1 – 3.1.3

# Popular Linux Commands
- `ls`, `ls -a` (-a (all) is for listing hidden files)
- `cat`: file viewing more (less) and files redirects
- `touch`: making a file
- `pwd`: displaying current location
- `cd` and the following `.` and `..` Directories,
`/` (root) and the Unix directory tree, `~`,$(HOME) and default directories
- `mv` and `cp`: move and copy
- `mkdir`: making a subdirectory
- `rm`, `rmdir`, `rm -d`, `rm -rf`: Removing files and subdirectories
- `df` and `du`

# Purpose


# Navigating the application
To run hello.s enter the following command into your shell prompt.

`gcc Hello.s -g -c -o Hello.o`

The above `gcc` command has many options, three are used in this instance.

`-g` informs the assembler that debugging information should be produced

`-c` says that the assembler is to only assemble code to an object file
and not attempt to make an executable from it.

`-o` option informs the compiler to save output to an output file
with the name specified after the option. In this instance, it's `hello.o`

Ultimately, the outcome of the above command is a file named `hello.o`
which is an object file containing the result of translated assembly code
in the file hello.s into machine code.

From here on out, we have to use something called an object linker
this is so we may resolve any external references in our program
(in our case this would be the printf function).
After our linker is run using the following command,
the expected output is the writing of an executable file that can be run.

`gcc hello.o -g -o hello`

We can continue now to run our program using the following command:

`./hello`
# Assignment
