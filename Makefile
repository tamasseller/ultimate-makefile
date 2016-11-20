OUTPUT = fw.elf

SOURCES += Main.cpp
INCLUDE_DIRS += .

GCCPATH = /opt/gcc-arm-none-eabi-5_4-2016q3
GCCPREF = $(GCCPATH)/bin/arm-none-eabi-
CC = $(GCCPREF)gcc
CXX = $(GCCPREF)g++
LD = $(GCCPREF)ld
OBJCOPY = $(GCCPREF)objcopy

LIB_DIRS += $(GCCPATH)/arm-none-eabi/lib/armv7e-m/fpu

DFLAGS += -DARM_MATH_CM3=1
DFLAGS += -DUSE_STDPERIPH_DRIVER=1 

WFLAGS += -Wno-attributes

ARCHFLAGS += -mcpu=cortex-m4
ARCHFLAGS += -mthumb
ARCHFLAGS += -mfpu=fpv4-sp-d16
ARCHFLAGS += -mfloat-abi=hard

COMMONFLAGS += $(WFLAGS) $(DFLAGS) $(ARCHFLAGS)
COMMONFLAGS += -O0 -g3  
COMMONFLAGS += -include compat.h

CFLAGS = $(COMMONFLAGS) -std=c11 -static 
CXXFLAGS = $(COMMONFLAGS) -std=c++11 -Wno-literal-suffix -fno-rtti -fno-builtin -fno-exceptions -fno-unwind-tables -ffreestanding

LIBS += c

LDFLAGS += -gc-sections
LDFLAGS += -nostartfiles
LDFLAGS += -Tplatform/stm32.ld

include Makefile.engine

$(OUTPUT).bin: $(OUTPUT)
	$(OBJCOPY) -O binary $< $@

deploy: $(OUTPUT).bin
	util/st-flash write $(OUTPUT).bin 8000000
