STKPTR ?= 0x10000
__STACK_SIZE = $(STKPTR)
CFLAGS = -Wall --std=c99 -ffreestanding -nostdlib -mthumb -mcpu=cortex-m3  -msoft-float
all: $(TARGET).bin

init.o: init.S
	@echo "Building object file $@ for $<"
	arm-linux-gnueabihf-gcc -c -Qn -D__STACK_SIZE=$(__STACK_SIZE) $(CFLAGS) $< -o $@ 

%.elf: init.o  %.o
	@echo "Combining object files $< to produce $@"
	gcc -static $(CFLAGS) -Wl,-Bstatic,-T,cortexm3.ld,--build-id=none \
		-mtune=cortex-m3 $^ -o $@

%.o: %.c
	@echo "Building object file $@ for $<"
	gcc $(CFLAGS) -c $< -o $@

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	arm-linux-gnueabihf-objcopy $< -O binary $@
.PRECIOUS: %.elf %.o


clean:
	rm -rf *.hex *.bin *.elf *.o
