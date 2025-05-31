CFLAGS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore # this is to tell the compiler there is no OS to make sure of all of these things
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
	mkdir -p boot/grub
	cp mykernel.bin boot/mykernel.bin
	echo 'set timeout=0' > boot/grub/grub.cfg
	echo 'set default=0' >> boot/grub/grub.cfg
	echo 'set hidden_timeout=0' >> boot/grub/grub.cfg
	echo '' >> boot/grub/grub.cfg
	echo 'menuentry "My OS" {' >> boot/grub/grub.cfg
	echo '    multiboot /mykernel.bin' >> boot/grub/grub.cfg
	echo '    boot' >> boot/grub/grub.cfg
	echo '}' >> boot/grub/grub.cfg

iso: install
	i686-elf-grub-mkrescue -o myos.iso boot/

qemu: myos.iso
	qemu-system-i386 -cdrom myos.iso

format:
	clang-format -i *.cpp *.h

clean:
	rm -f *.o mykernel.bin myos.iso
	rm -rf boot/

.PHONY: install iso qemu format clean