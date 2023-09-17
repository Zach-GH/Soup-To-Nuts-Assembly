# Soup-To-Nuts-Assembly Module 3
Zachary Meisner 9/17/23

https://github.com/Zach-GH/Soup-To-Nuts-Assembly

[Sections 3.1.1 – 3.1.3](https://cupola.gettysburg.edu/cgi/viewcontent.cgi?article=1007&context=oer)

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
The purpose of this Module 3 folder is to familiarize myself with the OS provided to be by the school, debug and attempt to run the initial VM environment that I have set up and improve it, and to get my feet wet with the actual programming of Assembly language, as well as creating a corresponding Makefile.

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

How to Install VIM
---

`sudo apt-get update`
`sudo apt-get install vim`
`which vim` you should see `/usr/bin/vim` print out if installed properly

Getting started with VIM
---

1. Just running the command `vim` will open VIM in the command line.
2. To create a file, use the following command `:edit sample.txt` which will open a sample text file in edit mode if it exists, and creates a new file otherwise.
3. After the creation of the file, you will want to enter `i` to enter insert mode, where you are then able to enter any text you would like in the file.
4. When finished, press the `ESC` key, and enter `:w` to save/write to your file.
5. Enter `:q` for quit, to exit out of VIM and continue entering any corresponding commands neccesary.
6. Additionally, to save time you can use `:wq` for write/quit
7. Lastly, to save time opening your file, you can target the needed file directly in the case that it already exists, for example, if you were to create your file using `touch sample.txt` you then would be able to run `vim sample.txt` to directly open the file without needing to create it inside of VIM.

# Errors
1. The first error I ran into was simply because I was using a capital instead of a lowercase, this is likely a mistake in the book, however changing the commands from `gcc Hello.s -g -c -o Hello.o` to `gcc hello.s -g -c -o hello.o`fixed the problem
2. The second error I ran into is the following:

<img width="449" alt="Screenshot 2023-09-17 at 12 52 37 PM" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/767af8ee-b14c-428c-95ea-24fe89277820">

This may have something to do with my initial grabbing of the code, but more investigation is needed on the matter to determine the exact case in which this is happening. This is paired to the following commit: [de2e83d](https://github.com/Zach-GH/Soup-To-Nuts-Assembly/commit/de2e83d04136bd26d70b3612319c0e10ef5511bc)

After looking up some documentation on the code, in addition to playing around with some of the brackets, in addition to recoding the application in VIM I got the idea that it maybe the environment I am using (as I downloaded my own VM of the latest Raspberry Pi OS for x32 which I believe is presently Debian 11) so I ssh'd into my school provided Raspberry Pi Account, and ran the same commands, only to find that I ran into no issues and my commands for the program successfully worked. This can be seen below:

<img width="727" alt="Screenshot 2023-09-17 at 1 44 35 PM" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/c33ab3e6-8f36-4efd-bac8-9252167be3f6">

Interestingly enough, I found documentation to suggest that I am using a newer version of the compiler itself, as I cannot imagine why it would be the OS.

I then ran `cat /etc/os-release` to evaluate any potential differences, and found that the student server I have uses `Raspbian GNU/Linux 10 (buster)` and like I had previously mentioned, the VM I am using utilizes `Debian GNU/Linux 11 (bullseye)` I am unsure what underlying differences between the two there maybe, but it is at least a start of understanding the differences of both OS environments, and how Assembly is configured and works dependent on the OS.
