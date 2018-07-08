	AREA	AsciiAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, ='2'	; R1 = 0x32 (ASCII symbol '2')
	LDR	R2, ='4'	; R2 = 0x34 (ASCII symbol '4')
	
	; Change these characters between 0 and 4 in the registers R1 and R2
	; as per the assignment details i.e. load the character '1' in R1
	; and '3' in R2, and R0 will equal 0x04 in hex i.e. 1 + 3 = 4.
	
	SUB R3, R1, '0'		; R3 = the VALUE of 2 in decimal
	SUB R4, R2, '0'		; R4 = the VALUE of 4 in decimal
	
	; The character of '0' in ASCII represents 0x30 in hex, therefore
	; subtracting the character of '0' from the characters of '2' and '4' 
	; in ASCII should give the hex value of the correct decimal values
	
	ADD R0, R3, R4		; R0 = the VALUE of 6 in decimal
	
stop	B	stop

	END