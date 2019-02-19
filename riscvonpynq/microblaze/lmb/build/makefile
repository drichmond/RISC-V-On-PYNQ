STKPTR ?= 0x10000
PROCESSOR ?= default
GCC_OPTS = -O2 -static -std=gnu99 -ffast-math --freestanding -nostdlib -mno-xl-soft-mul -mno-xl-soft-div -mxl-barrel-shift
LINK_OPTS = -static -nostdlib -nostartfiles -lm -lgcc -Wl,-Bstatic,--strip-debug,-T,mb.ld -lgcc -lc
all: $(TARGET).bin

%.elf: reset.o %.o
	@echo "Combining object files $< to produce $@"
	mb-gcc -Os -ffreestanding -nostdlib -o $@ \
		$(LINK_OPTS) \
		$^ -lgcc -mcpu=v10.0 -mlittle-endian  

%.o: %.c 
	@echo "Building object file $@ for $<"
	mb-gcc $(LINK_OPTS) -c -Qn -mcpu=v10.0 -mlittle-endian -o $@ -Os --std=c99 $< 

%.o: %.cpp
	@echo "Building object file $@ for $<"
	mb-g++ $(LINK_OPTS) -c -Qn -mcpu=v10.0 -mlittle-endian -o $@ -Os $< 

%.o: %.S
	@echo "Building object file $@ for $<"
	mb-gcc $(LINK_OPTS) -c -Qn -DSTKPTR=$(STKPTR) -mcpu=v10.0 -mlittle-endian \
		-o $@ -Os --std=c99 $< 

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	mb-objcopy -O binary $< $@

# Use .PRECIOUS to keep elf files so that objdump can be run (for debugging)
.PRECIOUS: %.elf %.o

clean:
	rm -rf *.hex *.bin *.elf *.o
