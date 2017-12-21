

#Name of this library:
LIBNAME=projectlib

#Which files needed for this library:
SOURCES=stm8s_gpio.c
#SOURCES+= stm8s_i2c.c
#SOURCES+= stm8s_tim1.c

RELS=$(SOURCES:.c=.rel)

LIBRARY=$(LIBNAME).lib

SDCC=sdcc
SDLD=sdld
SDAR=sdar

PROCESSOR=stm8s103f3
DEBUGPROBE=stlinkv2

# Define tool path:
LIBROOT=/home/onat/elektronik/ARM/stm8/STM8S_StdPeriph_Lib/Libraries/STM8S_StdPeriph_Driver

INCLUDES=$(LIBROOT)/inc/
#Where source files are located:
SOURCEDIR=$(LIBROOT)/src/

CFLAGSLIB= -I$(INCLUDES)
CFLAGSLIB+= -I.
CFLAGSLIB+= -I..
CFLAGSLIB+= -c

SDARFLAGS= -rc

#The macros are to keep the header files (which want to see a specific compiler and processor) happy.
MACROS= -D__CSMC__ -DSTM8S103
PROCTYPE= -lstm8 -mstm8

vpath %.c
vpath %.c $(SOURCEDIR)

all: $(LIBRARY)

clean:
	rm -f $(OBJS) $(OBJS:.rel=.cdb) $(OBJS:.rel=.map) $(OBJS:.rel=.lst) $(OBJS:.rel=.asm) $(OBJS:.rel=.lk) $(OBJS:.rel=.rst) $(OBJS:.rel=.sym)


$(LIBRARY) : $(SOURCES)


%.lib : $(RELS)  
	$(SDAR) $(SDARFLAGS) $@ $(RELS)

%.rel: %.c
	$(SDCC) $(MACROS) $(PROCTYPE) $(CFLAGSLIB) $(LDFLAGS) $<

clean:
	rm -f $(RELS) $(RELS:.rel=.cdb) $(RELS:.rel=.map) $(RELS:.rel=.lst) $(RELS:.rel=.asm) $(RELS:.rel=.lk) $(RELS:.rel=.rst) $(RELS:.rel=.sym)






