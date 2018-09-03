# enee645project
Project for LLVM optimization

INTRODUCTION TO LLVM_IR

 

The human readable IR that was obtained in the last section can be opened using any editor of your choice.

The first thing that will be helpful in understanding the human readable LLVM would be to understand few of the instructions present in the intermediate representation of LLVM. The language reference manual is present here. A few instructions that would be good to know are:

·         Terminator Instructions

·         Binary Operations

·         Memory Access and Addressing Operations

·         Integer Compare Instruction The types present in llvm are described here.

  

IMPLEMENTATION IN LLVM

You can follow the following procedure to implement the function cloning pass:

0.   Define a new integer global variable and initialize it with an arbitrary value.

1.   At every call site in the program, check if the cloning needs to be done.

2.   If so, create a new function by cloning the original function definition.

3.   Then you need to add two IR instructions before the return instruction. First instruction should store the return value, if any, to the global variable defined in step 0. Second instruction is a call to the function pop_direct_branch.

4.   Then, if the original function has a return value, you need to add one IR instruction after the call site which should load the return value from the global variable to the intended variable.

5.   Replace the function at the call site with the newly cloned function.

 

Hints on how to write the above passes are in the “Steps involved” section below.

INFRASTRUCTURE TO WRITE YOUR OWN PASS

A sample project has been created for you to write your own pass. A good initial step before writing your own pass is to compile the pass in the sample folder and check if it works. This will ensure that you do not have any environment bugs when you write your own pass. The example pass present in the lib folder called Hello prints out the name of every function present in the bytecode. Follow the steps below to get it running on your machine.


(1) First copy the sample directory present at /afs/glue/class/old/enee/759c/llvm/sample to your local directory, say ~/xyz/sample. You can use "cp -R" to copy a directory and its contents.

(2) Create two other directories at the same level (i) obj directory, say ~/xyz/obj and (ii) an install directory called opt at ~/xyz/opt

(3) Configure the build system in the obj directory as follows:

~/xyz/obj$ ../sample/configure --with-llvmsrc=/afs/glue/class/old/enee/759c/llvm/llvm-3.4.src --with-llvmobj=/afs/glue/class/old/enee/759c/llvm/llvm-3.4-install/obj --prefix=/homes/your-user-name/xyz/opt 

(4) You can build it and test it out as follows: 

~/xyz/obj$ make install

llvm[0]: Installing include files

make[1]: Entering directory `/afs/glue.umd.edu/home/glue/n/e/neroam/home/xyz/obj/lib'

make[2]: Entering directory `/afs/glue.umd.edu/home/glue/n/e/neroam/home/xyz/obj/lib/Hello'

llvm[2]: Compiling Hello.cpp for Release+Asserts build (PIC)

llvm[2]: Linking Release+Asserts Shared Library libHello.so

llvm[2]: Building Release+Asserts Archive Library libHello.a

llvm[2]: Installing Release+Asserts Shared Library /homes/neroam/xyz/opt/lib/libHello.so

llvm[2]: Installing Release+Asserts Archive Library /homes/neroam/xyz/opt/lib/libHello.a

make[2]: Leaving directory `/afs/glue.umd.edu/home/glue/n/e/neroam/home/xyz/obj/lib/Hello'

make[1]: Leaving directory `/afs/glue.umd.edu/home/glue/n/e/neroam/home/xyz/obj/lib' 

 

[There would be many more lines ... only few reproduced here]


(5) Set the PATH variable to also have the llvm installation as follows:


~/xyz/obj: setenv PATH /afs/glue/class/old/enee/759c/llvm/llvm-3.4-install/opt/bin/:$PATH


Check that the installation is correct as follows

 

~/xyz/obj: opt --version 

LLVM (http://llvm.org/):

  LLVM version 3.4

  Optimized build.

  Built Mar 17 2014 (12:45:22).

  Default target: x86_64-unknown-linux-gnu

  Host CPU: penryn


(6) You can run your pass as follows:


~/xyz/obj: opt -load ../opt/lib/libHello.so -hello /afs/glue/class/old/enee/759c/llvm/test_codes/example1.bc -o example.1hello.bc

 

The above command will optimize the example1.bc bytecode with the “-hello” optimization and produce as output optimized bytecode in example1.hello.bc. This optimization is present in the libHello.so library. 

 

[The output should look like]


Hello: main

 

It prints out the names of all functions present in this module.

 

Later when you write your own optimization, write it in the sample/lib directory. The compile and install it using steps (3) and (4) above.  This should produce a new library with a .so extension.  Then use the above command with the library name that you generated in place of libHello.so, and the name of your optimization in place of  “-hello”. This will apply your transformation to the bytecode file specified.

