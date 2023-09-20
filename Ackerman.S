.data //data section
.text//program section
.global main //main
.global A //Ackerman function
.arch armv8-a+fp+simd //processor type
.type main, %function//main function
.type A, %function //AckermanFunction
main:
	MOV X27,SP//Copy the stack pointer to X27
	MOV X0,#3 //X0 will contain m
	MOV X1,#4//X1 will contain n
	BL A //Call Ackerman
	B exit//exit main
A: //Condition 1
	CMP X0,#0//Compare m to 0
	BNE C2 //Go to condition 2 if not equal to 0
	ADDS X2,X1,#1 //Set X2 to X1 + 1 or X2 = n + 1
	RET X30 //Return
C2://Condtion 2
	SUBS X27,X27,#16 //Allocate 2 spaces in stack
	STUR X0,[X27,#8] //Save X0 or m
	STUR X30,[X27,#0]//Save return address
	CMP X1,#0 //Compare n to 0
	BNE C3 //Branch to condition 3
	SUBS X0,X0,#1//Set X0 to m - 1
	MOV X1,#1 //Set n to 1
	BL A//Call A(m-1,1)
	LDUR X0,[X27,#8]//Load X0 again
	LDUR X30,[X27,#0]//Restore X30 from stack
	ADDS X27,X27,#16//Pop the stack
	RET X30
C3://Condtion 3
	SUB X1,X1,#1 //Set X1 to n - 1
	BL A //Call A(m,n-1)
returnToMain:
	MOV X1,X2 //Set X1 to return value X2
	LDUR X0,[X27,#8]//Restore X0
	SUBS X0,X0,#1 //Set original m to m - 1
	BL A //Call A(m-1,returned value)
	LDUR X30,[X27,#0]//Restore X30 from stack
	ADDS X27,X27,#16//Pop the stack
	RET X30 //Return
