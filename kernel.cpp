void printf(const char* str) {
    unsigned short* videoMemory = (unsigned short*)0xb8000;
    for (int i = 0; str[i] != '\0'; i++) {
        videoMemory[i] = (videoMemory[i] & 0xFF00) | str[i];
    }
}

// This is to run the functions that contain any global vars so they are available,
// since they get stored between these two pointers separate from the program
typedef void (*constructor)();
extern "C" constructor start_ctors;
extern "C" constructor end_ctors;
extern "C" void callConstructors() {
    for (constructor* i = &start_ctors; i != &end_ctors; i++) {
        (*i)();
    }
};

extern "C" void kernelMain(void* multiboot_struct, unsigned int magic) {
    printf("Welcome to my custom C++ OS");

    while (1) {
    }
}
