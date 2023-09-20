.data     		// data section
	.type  container, %object  // defining object v

container:     				// v array
	 .xword 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 0  // elements of size 64-bits

	 .text     // program section
	 .globl main
	 .arch armv8-a+fp+simd // processor type
	 .type main, %function

main:
	ADR X9, container // load the base address of container into X9
	MOV X10, #0 // This is the sum stored in X10
	MOV X12, #0 //This is the i value times 8
	MOV X13, #0 //This is the i value


loopstart:
	LSL X12, X13, #3 // X12 = i * 2^3, or i * 8
	ADD X12,X9,X12 //Add newbase = oldbase + (i * 8)
	ADD X13, X13, #1 // Increment i by 1
	LDUR X11, [X12] // Load the next value
	CBZ X11, exit //If the first value is 0 then exit loop
	TST X11, #1//Check if the last bit value is 1 or 0, if 1 then odd, if odd loop back
	BNE loopstart //Restart the loop
	ADD X10,X10,X11 //Otherwise add it to the sum
	 B loopstart //go back to loop
exit: //Exit the loop



