.data //data section
.text //program section
.global main //main
.global fact // factorial function access
.arch armv8-a+fp+simd // processor type
.type main, %function //main function
.type fact, %function //fact function declaration

main:
	MOV X27, SP //Copy stack pointer to register X27
	MOV X0, #4 //declare n as 4
	BL fact //Call the function fact
	B exit //exit main
	//Note register 1 will hold the return value
fact:
	SUB X27,X27,#16 //Save return address and n on stack
	STUR X30,[X27,#8] //Store return address on the stack or LR
	STUR X0,[X27,#0]//Store n on the stack
	SUBS XZR,X0,#1 // compare n and 1 and throw away the result from the subtraction
	B.GE L1 //branch to L1 if n >= 1
	MOV X1,#1 //Otherwise return 1
	ADD X27,X27,#16 //Pop the stack
	BR X30 //Return or LR
L1: SUB X0,X0,#1 // n = n -1
	BL fact //Call fact(n-1)
A1: LDUR X0,[X27,#0] //Restore caller's n
	LDUR X30,[X27,#8] //Restore caller's return adress
	ADD X27,X27,#16 //Pop the stack
	MUL X1,X0,X1 //Return n * fact(n-1)
	BR X30 //Return
exit:

