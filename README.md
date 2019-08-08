# Using SDCC for STM8 with STM8S_StdPeriph_Lib official libraries.

STM8 is an interesting processor. It is very simple to understand by one person but has a modern core and peripheral architecture. Extremely cheap small development boards and device programmers are available, so it makes for a very good base to learn embedded programming on. 

ST Microelectronics has a nice standard peripheral library (provided as source and with examples) that simplifies code development. However, the standard peripheral library was meant to be compiled **only with commercial compilers** which require registration, and capability limitation in the evaluation (free) versions. The packages are also quite large to download and install, for such a simple processor.

Simple Device C Compiler (SDCC) is now supporting STM8 processors. However, some effort is needed to adapt the ST Standard Peripheral Library to SDCC, especially if GNU make will be used for compilation. Here the necessary steps to build and run a LED blink code are provided, which will give the insight to get you going. 

SDCC has one peculiarity: It can only compile one source file, which makes it somewhat tricky to build projects with many files. However, it has a solution that all the accompanying files in a project can be compiled into one project specific library (with .lib extension), which is then linked against the main source file during final compilation. The provided Makefile automaticaly does this and flashes the code to the processor.

The sample project I provide here blinks the LED on a small STM8S103F3P6 board, typically going by the trade name of "minimum  system development board". The device programmer is a cheap ST-LINK V2 with an included SWIM port.

## How to use:
(In Linux)
- Install SDCC (I used version 3.5.0; earlier versions do not support stm8). 
- Download the ST 'STM8S_StdPeriph_Lib' under a suitable folder.
- Modify the file 'STM8S_StdPeriph_Lib/Libraries/STM8S_StdPeriph_Driver/inc/stm8s.h' (explained below)
- Edit the 'Makefile' provided to modify the library path.
- Similarly edit the 'Makefile' in 'libs' directory.
- Install ['stm8flash'](https://github.com/vdudouyt/stm8flash/) It is a device progammer for the SWIM port of the ST-Link V2 programmer
- in the project folder type `make flash`

The last step will compile the library file as `./libs/projectlib.lib`, compile main.c into `main.ihx`, and finally flash the code on the processor.

Once you set up your project correctly, all that you need to do for a re-build any time you modify your source and want to flash the code on your processor is to execute `make flash`. It is possible to remove the intermediate files by executing `make clean` or simply compile the project by executing `make`.

## Modification of the Library file

The convention for inline assembly command inclusion (`asm`) for the compilers officially supported for STM8 is different than SDCC. This fails the compilation. Although the library can be augmented by adding SDCC to all the include and source files, this is tedious and difficult to maintain. For most projects, the remedy is to trick the library to think that we are compiling for a supported compiler, and modify the 'asm' definitions relating to that compiler in the header files, to SDCC syntax.

The file requiring modification is 'STM8S_StdPeriph_Lib/Libraries/STM8S_StdPeriph_Driver/inc/stm8s.h'. 
Find all the lines that have an 'asm' command:
```c
#define halt()                {_asm("halt\n");}
```

and modify them as:

```c
#define halt()                __asm__("halt\n");
```

And that's it. You can find more informaton at my Blog:

http://aviatorahmet.blogspot.com.tr/2018/01/programming-stm8s-using-sdcc-and-gnu.html

I have had a great boost by reading this source:

https://www.cnx-software.com/2015/04/13/how-to-program-stm8s-1-board-in-linux/

Note that some chips come with code protection fuse bits set. This prevents write attempts. It is a simple matter to change the bits and make the device writeable. See, for example:
https://github.com/vdudouyt/stm8flash/issues/38 and read the comment by @minobull on 23 Apr 2016:

```bash
echo "00 00 ff 00 ff 00 ff 00 ff 00 ff" | xxd -r -p > factory_defaults.bin
stm8flash -c stlinkv2 -p stm8s103f3 -s opt -w factory_defaults.bin
```
