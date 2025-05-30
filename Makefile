CFLAGS = -m32
ASFLAGS = --32
LDFLAGS = -melf_i386

OBJS = loader.o kernel.o

%.o: %.cpp
	x86_64-elf-g++ $(CFLAGS) -o $@ -c $<

%.o: %.s
	x86_64-elf-as $(ASFLAGS) -o $@ $<

mykernel.bin: linker.ld $(OBJS)
	x86_64-elf-ld $(LDFLAGS) -T $< -o $@ $(OBJS)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

format:
	clang-format -i *.cpp