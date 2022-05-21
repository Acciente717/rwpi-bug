CC = ~/opt/llvm-14/bin/clang
OBJDUMP = arm-none-eabi-objdump

CFLAGS = -Og
CFLAGS += --target=armv7em-none-eabi
CFLAGS += -mfloat-abi=soft
CFLAGS += -fropi -frwpi

LDFLAGS = -fuse-ld=lld
LDFLAGS += -nostdlib
LDFLAGS += -Tlink.ld
LDFLAGS += $(CFLAGS)

SRCS := $(wildcard *.c)
OBJS := $(patsubst %.c,%.o,$(SRCS))

all: image.elf

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

startup.o: startup_stm32f407vgtx.s
	$(CC) $(CFLAGS) -c -o $@ $<

image.elf: $(OBJS) startup.o
	$(CC) $(LDFLAGS) -o image.elf $^

dump: image.elf
	$(OBJDUMP) -d image.elf > dump.asm

clean:
	rm -f *.o
	rm -f image.elf
	rm -f dump.asm
