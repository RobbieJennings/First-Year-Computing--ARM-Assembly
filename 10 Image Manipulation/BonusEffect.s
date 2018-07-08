	AREA	Adjust, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start
	PRESERVE8

start

	BL	getPicAddr			; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight		; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth			; load the width of the image (columns) in R6
	MOV	R6, R0
	
	MUL R7, R5, R6			; get size of image
	LDR R8, =0				; set pixel count to 0
	
while1
	
	CMP R8, R7				; while( pixel count < size of image )
	BHS endWhile1			; {
	
	LDR R9, =0				; 	colour count = 0
	LDR R0, [R4]			; 	load pixel from memory
	LDR R10, =0
	
while2

	CMP R9, #3				; 	while( colour count < 3 )
	BHS endWhile2			;	{
	
	AND R11, R0, #0x00FF0000; 		get individual colour
	LSR R11, R11, #16		; 		shift colour to end of word
	
	LSL R0, R0, #8			; 		shift all colours left
	ADD R10, R10, R11		;		add new colour to total
	ADD R9, R9, #1			; 		colour count ++
	
	B while2				; 	}

endWhile2

	LDR R11, =0				; 	set quotiant to 0

while3	

	CMP R10, #3				; 	if( 3 is larger than total)
	BLO endwhile3			; 	{
	
	SUB R10, R10, #3		; 		Subtract 3 from total
	ADD R11, R11, #1		; 		Add 1 to quotiant

	B while3				; 	}
	
endwhile3
	
	LDR R0, =0				;	set colour to 0
	ADD R0, R0, R11			; 	add quotiant to pixel
	LSL R0, #8				;	shift pixel left
	ADD R0, R0, R11			; 	add quotiant to pixel
	LSL R0, #8				; 	shift pixel left
	ADD R0, R0, R11			; 	add quotiant to pixel
	
	STR R0, [R4]			; 	store pixel in memory
	
	ADD R8, R8, #1			; 	pixel count ++
	ADD R4, R4, #4			; 	memory address ++
	
	B while1				; }
	
endWhile1

	BL	getPicAddr			; load the start address of the image in R4
	MOV	R4, R0
	
	LDR R5, =0				; set pixel count to 0

while4

	CMP R5, R7				; while( pixel count < size of image )
	BHS endWhile4			; {
	
	LDR R6, [R4]			; 	load pixel at memory address into R6
	STR R6, [SP, #-4]!		; 	push pixel onto stack
	ADD R5, R5, #1			; 	pixel count ++
	ADD R4, R4, #4			; 	memory address ++
	
	B while4				; }
	
endWhile4

	BL	getPicAddr			; load the start address of the image in R4
	MOV	R4, R0
	
	LDR R5, =0				; set pixel count to 0

while5

	CMP R5, R7				; while( pixel count < size of image )
	BHS endWhile5			; {
	
	LDR R6, [SP], #4		; 	pop pixel off stack into R6
	STR R6, [R4]			; 	store pixel in memory address
	ADD R5, R5, #1			; 	pixel count ++
	ADD R4, R4, #4			; 	memory address ++
	
	B while5				; }

endWhile5

	BL	putPic				; re-display the updated image

stop	B	stop

	END