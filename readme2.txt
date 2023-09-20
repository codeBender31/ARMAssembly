The goal of this program is to add all the even numbers in any array of any size.
Use of registers
X9 - Base adress of array
X10 - Stores the sum of the elements
X11 - Loads the next value
X12 - New address = base address + (i * 8)
X13 - i value starting at 0, upping by 1 each iteration
