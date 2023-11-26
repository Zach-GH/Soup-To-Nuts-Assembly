# Soup-To-Nuts-Assembly

Preface
---

The work I did in my Computer Organization class taught by Charles Kahn at JHU, following these books

[Introduction to Assembly Language Programming From Soup to Nuts](https://cupola.gettysburg.edu/oer/8/)

[Digital Circuit Projects: An Overview of Digital Circuits Through Implementing Integrated Circuits - Second Edition](https://cupola.gettysburg.edu/cgi/viewcontent.cgi?article=1000&context=oer)

[Implementing a One Address CPU in Logisim](https://cupola.gettysburg.edu/cgi/viewcontent.cgi?article=1002&context=oer)

A lot of the work in my class was done in MIPS/ARM assembly, in addition to using Logism to create circuit maps. Early on in the class, we additionally were asked to demonstrate our abilities to create programs to implement some of the basic logic needed for programmatically setting and manipulating the mathematical variables used in binary and hex values to understand the overall communications a computer transliterates during runtime.

There is more work that was done in this class that is not displayed, such as the conversion of binary values to the assembly code, and the assembly code to the binary value, converted using state maps provided to us, as well as a defined structure for transliterating each command.

This is but a small summation of the work done in this class, as we were avidly researching and studying not only the implementation and use-case of the language itself, but the environments and scenarios in which you would want to use and implement the language, and the differences/relationships that it has with High Level Programming Languages, as well as the different decisions an engineer or developer may have to make in the field when it comes to safe programming, and the implementation of common programming decisions, such as procedural code v. structural code, static versus non-static, and much more.

Run Logism
---
To run Logism, I would have to download Logism for MacOSx and then I would have to run `sudo java -jar logism.jar` as running it normally would not work and crash with an error. Additionally, the sudo command has to be run to allow the jar file to save the created .circ files for any created circuits.

Set Up Vim
---
To set-up VIM with the ability to recognize and manipulate the correct kind of Assembly code that we were using, I had to first find the module targeted towards the language. This was difficult, as there is only one module available online that exists, but after I found it, it was simple to download and utilize the package. In this case, I am referring to `mips.vim` located in the vim folder.

You can see in the screenshot below, the trick here is to specify the runtime path as the `~/.vim/` pathway, but to have the actual source and dependency path as the package (which is located in your folder). This is due to my lack of permissions to place this package in the .vim directory, and VIM as a program has backdoor access, where-as you as a user did not.

This is set up in a [.vimrc](https://github.com/Zach-GH/Soup-To-Nuts-Assembly/blob/main/vim/.vimrc) configuration file (which I had to create as it did not exist prior) 

<img width="553" alt="Vim_Setup" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/d8858b97-fd7b-42f0-8eda-68e2db85eccc">

The following screenshot is what the setup looked like after I configured everything properly.

<img width="857" alt="Mips_Vim_Setup" src="https://github.com/Zach-GH/Soup-To-Nuts-Assembly/assets/80639692/8eaaf2b6-7450-49c7-a7a7-e615ec5d7234">

