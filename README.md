## Minimum Code Example Showing Wrong RWPI Relocation

### Build
- Build the LLVM 14 toolchain.
- Modify `Makefile`. Update `CC` to the built `clang`.
- Run `make`.

### Verification
- Run `make dump` to generate the disassembly file.
- Examine the main function.

### Example Build Result

The following disassembly shows that after relocation `vola1` and `vola4` are pointed to the same address.

```
080001a8 <main>:
 80001a8:	f240 0000 	movw	r0, #0
 80001ac:	f2c0 0000 	movt	r0, #0
 80001b0:	f859 1000 	ldr.w	r1, [r9, r0] ; fetching vola1 from [%r9 + 0]
 80001b4:	3101      	adds	r1, #1       ; vola1 += 1
 80001b6:	f849 1000 	str.w	r1, [r9, r0] ; storing vola1
 80001ba:	f240 0008 	movw	r0, #8
 80001be:	f2c0 0000 	movt	r0, #0
 80001c2:	f859 1000 	ldr.w	r1, [r9, r0]
 80001c6:	3102      	adds	r1, #2
 80001c8:	f849 1000 	str.w	r1, [r9, r0]
 80001cc:	f240 0004 	movw	r0, #4
 80001d0:	f2c0 0000 	movt	r0, #0
 80001d4:	f859 1000 	ldr.w	r1, [r9, r0]
 80001d8:	3103      	adds	r1, #3
 80001da:	f849 1000 	str.w	r1, [r9, r0]
 80001de:	f240 0000 	movw	r0, #0
 80001e2:	f2c0 0000 	movt	r0, #0
 80001e6:	f859 1000 	ldr.w	r1, [r9, r0] ; fetching vola4 from [%r9 + 0] again ???
 80001ea:	3104      	adds	r1, #4       ; vola4 += 4
 80001ec:	f849 1000 	str.w	r1, [r9, r0] ; storing vola4
 80001f0:	f240 0104 	movw	r1, #4
 80001f4:	f2c0 0100 	movt	r1, #0
 80001f8:	f859 0001 	ldr.w	r0, [r9, r1]
 80001fc:	1d42      	adds	r2, r0, #5
 80001fe:	2000      	movs	r0, #0
 8000200:	f849 2001 	str.w	r2, [r9, r1]
 8000204:	4770      	bx	lr
```

#### Toolchain Version
```
clang version 14.0.4 (https://github.com/llvm/llvm-project.git 5f66e721ec1d099cf2370235ce122cf47c287308)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: ~/opt/llvm-14/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/8
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/9
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/9
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Candidate multilib: x32;@mx32
Selected multilib: .;@m64
```
