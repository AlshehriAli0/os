CFLAGS = -m32
ASFLAGS = --32
LDFLAGS = -melf_i386

OBJS = loader.o kernel.o

%.o: %.cpp
	g++ $(CFLAGS) -o $@ -c $<

%.o: %.s
	as $(ASFLAGS) -o $@ $<

mykernel.bin: linker.ld $(OBJS)
	ld $(LDFLAGS) -T $< -o $@ $(OBJS)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

format:
	clang-format -i *.cpp