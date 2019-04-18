CFLAGS = -Wall --std=c99 -ffreestanding -nostdlib -marm -mtune=cortex-m1
all: $(TARGET).bin

init.o: init.S
	@echo "Building object file $@ for $<"
	arm-linux-gnueabihf-as $< -o $@


%.elf: system.o init.o %.o
	@echo "Combining object files $< to produce $@"
	gcc -static -ffreestanding -nostdlib -marm -mtune=cortex-m1 $< -o $@

%.o: %.c
	@echo "Building object file $@ for $<"
	gcc $(CFLAGS) -c $< -o $@

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	arm-linux-gnueabihf-objcopy $< -O binary $@
.PRECIOUS: %.elf %.o


clean:
	rm -rf *.hex *.bin *.elf *.o
