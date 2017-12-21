
#include libs/Makefile

OBJECT=main
LIBFILE=projectlib.lib
LIBFILEPATH= ./libs

HEXFILE=$(OBJECT).ihx
SRCFILE=$(OBJECT).c

SDCC=sdcc
SDLD=sdld
PROCESSOR=stm8s103f3
#PROCESSOR=stm8s003f3
DEBUGPROBE=stlinkv2

# Define paths:
#Modify the following line to suit your installation:
LIBROOT=/home/onat/elektronik/ARM/stm8/STM8S_StdPeriph_Lib/Libraries/STM8S_StdPeriph_Driver
INCLUDES=$(LIBROOT)/inc/
DRIVERS=$(LIBROOT)/src/

vpath %.c
vpath %.c $(DRIVERS)

CFLAGS= -I$(INCLUDES)
CFLAGS+= -I.
CFLAGS+= -Ilibs

#The macros below are to keep the header files
#(which want to see a specific compiler and processor) happy.
MACROS= -D__CSMC__ -DSTM8S103
PROCTYPE= -lstm8 -mstm8
OUTPUTTYPE=--out-fmt-ihx

#.PHONY: all clean flash

#all: $(HEXFILE)
$(HEXFILE): $(LIBFILEPATH)/$(LIBFILE) $(SRCFILE)

clean:
	rm -f $(OBJECT).cdb $(OBJECT).map $(OBJECT).lk $(OBJECT).rst $(OBJECT).rel $(OBJECT).sym $(OBJECT).lst $(OBJECT).asm
	make clean -C $(LIBFILEPATH)

flash: $(HEXFILE)
	stm8flash -c$(DEBUGPROBE) -p$(PROCESSOR) -w $(HEXFILE)

%.ihx: %.c
	$(SDCC) $(MACROS) $(PROCTYPE) $(CFLAGS) $(LDFLAGS) $< $(LIBFILE) -L $(LIBFILEPATH)

# SDCC allows compilation of only 1 source file at a time.
# However, it allows linking in previously generated library files.
# The required library for this project is prepared from the standard
#  libraries by the Makefile in the $(LIBFILEPATH) directory.

$(LIBFILEPATH)/$(LIBFILE):
	make -C $(LIBFILEPATH)
