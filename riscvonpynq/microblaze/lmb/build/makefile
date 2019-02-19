STKPTR ?= 0x10000
PROCESSOR ?= default
GCC_OPTS = -Os -static -std=gnu99 -ffast-math --freestanding -nostdlib \
	-mno-xl-soft-mul -mno-xl-soft-div -mxl-barrel-shift
LINK_OPTS = -static -nostdlib -nostartfiles -Wl,-Bstatic,--strip-debug,-T,mb.ld \
	-lgcc -lc -lm
all: $(TARGET).bin

%.elf: reset.o %.o
	@echo "Combining object files $< to produce $@"
	mb-gcc $^ -o $@ -Qn $(GCC_OPTS) -mcpu=v10.0 -mlittle-endian $(LINK_OPTS)

%.o: %.c 
	@echo "Building object file $@ for $<"
	mb-gcc -c -o $@ $< -Qn $(GCC_OPTS) -mcpu=v10.0 -mlittle-endian \
		$(LINK_OPTS) -DSTKPTR=$(STKPTR) -DPROCESSOR=$(PROCESSOR)

%.o: %.cpp
	@echo "Building object file $@ for $<"
	mb-g++ -c -o $@ $< -Qn $(GCC_OPTS) -mcpu=v10.0 -mlittle-endian \
		$(LINK_OPTS) -DSTKPTR=$(STKPTR) -DPROCESSOR=$(PROCESSOR)

%.o: %.S
	@echo "Building object file $@ for $<"
	mb-gcc -c -o $@ $< -Qn $(GCC_OPTS) -mcpu=v10.0 -mlittle-endian \
		$(LINK_OPTS) -DSTKPTR=$(STKPTR) -DPROCESSOR=$(PROCESSOR)

%.bin: %.elf
	@echo "Converting .elf file $< into $@"
	mb-objcopy -O binary $< $@

# Use .PRECIOUS to keep elf files so that objdump can be run (for debugging)
.PRECIOUS: %.elf %.o

clean:
	rm -rf *.hex *.bin *.elf *.o
