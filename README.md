# Soup-To-Nuts-Assembly
The work I did in my Computer Organization class taught by Charles Kahn at JHU, following his book

[Introduction to Assembly Language Programming From Soup to Nuts](https://cupola.gettysburg.edu/oer/8/)

# Module 3 README help

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

# Navigating the application
To run `hello.s` enter the following command into your shell prompt.

`gcc Hello.s -g -c -o Hello.o`

The above `gcc` command has many options, three are used in this instance.

`-g` informs the assembler that debugging information should be produced

`-c` says that the assembler is to only assemble code to an object file
and not attempt to make an executable from it.

`-o` option informs the compiler to save output to an output file
with the name specified after the option. In this instance, it's `hello.o`

Ultimately, the outcome of the above command is a file named `hello.o`
which is an object file containing the result of translated assembly code
in the file `hello.s` into machine code.

From here on out, we have to use something called an object linker
this is so we may resolve any external references in our program
(in our case this would be the printf function).
After our linker is run using the following command,
the expected output is the writing of an executable file that can be run.

`gcc hello.o -g -o hello`

We can continue now to run our program using the following command:

`./hello`

Running with a Makefile
---

I have also created a corresponding Makefile to allow us to run the initial application, the commands can be found below:

<img width="928" alt="Screenshot 2023-09-17 at 2 17 51 PM" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/842e7e3f-e4f8-43d2-a8d2-3167a0700654">

You can see in my VIM display, that we have two commands for this file which can be run using the following commands: `make clean` that will remove any object or executable files within the corresponding folder and `make hello` which let you compile the hello file, so all you have to do after these two commands is enter `./hello` A demonstration can be seen below.

<img width="488" alt="Screenshot 2023-09-17 at 2 18 34 PM" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/04602523-8c9a-44d9-800e-d7ae046c0fe8">


# Using VIM
[Free Code Camp VIM Tutorial](https://www.freecodecamp.org/news/vim-beginners-guide/)

Popular VIM commands
---

- `:edit sample.txt` Create/Edit file
- `:wq` Save and Quit
- `:q!` Quit without save
- `y` Copy selected text
- `d` Cut selected text
- `p` Paste copied text
- `:[range]s/{pattern}/{string}/[flags]` Find and Replace
- `u` Undo
- `CTRL + R` Redo


Getting started with VIM
---

1. Just running the command `vim` will open VIM in the command line.
2. To create a file, use the following command `:edit sample.txt` which will open a sample text file in edit mode if it exists, and creates a new file otherwise.
3. After the creation of the file, you will want to enter `i` to enter insert mode, where you are then able to enter any text you would like in the file.
4. When finished, press the `ESC` key, and enter `:w` to save/write to your file.
5. Enter `:q` for quit, to exit out of VIM and continue entering any corresponding commands neccesary.
6. Additionally, to save time you can use `:wq` for write/quit
7. Lastly, to save time opening your file, you can target the needed file directly in the case that it already exists, for example, if you were to create your file using `touch sample.txt` you then would be able to run `vim sample.txt` to directly open the file without needing to create it inside of VIM.
