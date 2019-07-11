STKPTR ?= 0x10000
__STACK_SIZE = $(STKPTR)
CFLAGS=-Wall --std=c99 -nostdlib -mthumb -mcpu=cortex-m3 -march=armv7-m 
all: $(TARGET).bin

init.o: init.c
	@echo "Building object file $@ for $<"
	arm-none-eabi-gcc -c -Qn -D__STACK_SIZE=$(__STACK_SIZE) $(CFLAGS) $< -o $@ 

%.elf: init.o  %.o
	@echo "Combining object files $< to produce $@"
	arm-none-eabi-gcc $(CFLAGS) $^ -Wl,-Bstatic,-T,cortexm3.ld,--build-id=none -o $@

%.o: %.c
	@echo "Building object file $@ for $<"
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	arm-none-eabi-objcopy $< -O binary $@

.PRECIOUS: %.elf %.o

clean:
	rm -rf *.hex *.bin *.elf *.o
