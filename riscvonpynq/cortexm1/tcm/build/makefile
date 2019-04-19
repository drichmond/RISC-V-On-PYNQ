STKPTR ?= 0x10000
__STACK_SIZE = $(STKPTR)
CFLAGS = -Wall --std=c99 -ffreestanding -nostdlib -marm -mtune=cortex-m1
all: $(TARGET).bin

init.o: init.S
	@echo "Building object file $@ for $<"
	arm-linux-gnueabihf-gcc -c -Qn -D__STACK_SIZE=$(__STACK_SIZE) -marm -mtune=cortex-m1 $< -o $@ 

%.elf: init.o %.o
	@echo "Combining object files $< to produce $@"
	gcc -static -ffreestanding -nostdlib -marm -Wl,-Bstatic,-T,cortexm1.ld,--build-id=none \
		-mtune=cortex-m1 $^ -o $@

%.o: %.c
	@echo "Building object file $@ for $<"
	gcc $(CFLAGS) -c $< -o $@

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	arm-linux-gnueabihf-objcopy $< -O binary $@
.PRECIOUS: %.elf %.o


clean:
	rm -rf *.hex *.bin *.elf *.o
