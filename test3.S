	.data     		// data section
	.type  v, %object  // defining object v
	.size  v, 3   	// size 3 elements

v:     				// v array
	 .xword 1, 2, 3  // elements of size 64-bits

	 .text     // program section
	 .globl main
	 .arch armv8-a+fp+simd // processor type
	 .type main, %function

main:
	 ADR  X9, v   		// load base address of v into X9 (pseudo-instruction)
	 LDUR X10, [X9, #0]   // load the first value
	 LDUR X11, [X9, #8]   // load the second value
	 ADD  X10, X10, X11   // add the first and second value
	 LDUR X11, [X9, #16]  // load the third value
	 ADD  X10, X10, X11   // calculate the final sum
