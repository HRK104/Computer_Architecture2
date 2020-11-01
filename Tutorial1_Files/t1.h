#pragma once

//extern "C" int bias;
//extern "C" int _cdecl array_proc(int array[], int);

extern "C" int bias;
extern "C" int _cdecl fib_IA32a(int);   // _cdecl calling convention
extern "C" int _cdecl fib_IA32b(int);   // _cdecl calling convention
extern "C" int _cdecl array_proc(int array[], int);
extern "C" int _cdecl poly(int arg);
extern "C" int _cdecl factorial(int arg);
extern "C" void multiple_k_asm(uint16_t N1, uint16_t K1, uint16_t array[]);
