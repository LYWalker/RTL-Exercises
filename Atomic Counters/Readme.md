While working on the next generation SoC you were asked to design a 64-bit event counter which would be interfaced with a 32-bit bus controlled via a microcontroller. The 64-bit counter is incremented whenever a trigger input is seen. Given that the counter is read by a 32-bit bus, a full 64-bit read of the counter needs two 32-bit accesses. It is important that these two accesses should be single-copy atomic.

Design the 64-bit counter module and the appropriate interfacing mechanism to ensure single-copy atomic counter read operations.

> Publicly available [here](https://quicksilicon.in/course/rtl-design/module/atomic-counters).
>
> The rest of the question is copywrited