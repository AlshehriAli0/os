#ifndef __GDT_H
#define __GDT_H


class GlobalDescriptorTable {
   public:
    class SegmentDescriptor {
       private:
        uint16_t limit_lo;
    } __attribute__((packed));
    // This is used to tell the compiler to leave this in the exact place in the memory
    // we want it to be and not move it, it does that for perf reasons.
};

#endif