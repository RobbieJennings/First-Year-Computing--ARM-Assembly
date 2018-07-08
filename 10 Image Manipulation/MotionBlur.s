	AREA	MotionBlur, CODE, READONLY
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

	LDR R0, =5				; load blur raduis
	ADD R1, R0, R0			; double radius
	ADD R1, R1, #1			; add 1 ( blur diamater )
	
	LDR R2, =0				; x = 0
	LDR R3, =0				; y = 0
	
while1
	
	CMP R2, R6				; if( x >= width )
	BLO endCheck			; {
	
	ADD R3, R3, #1			; 	y ++
	LDR R2, =0				; 	x = 0

endCheck					; }

	CMP R3, R5				; while( y < height )
	BHS endWhile1			; {

	LDR R7, =16				; 	colour count = 16 ( used as shift later )
	LDR R8, =0xFF000000		; 	set mask to FF000000

while2

	CMP R7, #0				; 	while( colour count > 0 )
	BLT endWhile2			;	{
			
	LDR R9, =0				; 		set diagonal count to 0
	LDR R10, =0				;		set total colour to 0

	SUB R2, R2, R0			; 		x - blur radius
	SUB R3, R3, R0			; 		y - blur radius
	
	LSR R8, R8, #8			; 		shift mask two places

for

	CMP R9, R1				; 		for( diagonal count < blur diameter )
	BHS endFor				; 		{
	
	CMP R2, #0				; 			if( x >= 0 
	BLT outOfBounds
	
	CMP R2, R6				; 			&& x < width
	BHS outOfBounds
	
	CMP R3, #0				; 			&& y >= 0
	BLT outOfBounds
	
	CMP R3, R5				; 			&& y < height )
	BHS outOfBounds			; 			{
	
	MUL R11, R3, R6			; 				address = y * width
	ADD R11, R11, R2		; 				address + x
	LSL R11, R11, #2		; 				address * 4
	ADD R11, R4, R11		; 				address + starting address
	
	LDR R11, [R11]			; 				load pixel at address
	
	AND R11, R11, R8		; 				get individual colour (using mask)
	LSR R11, R11, R7		; 				shift colour to end of word (using colour count)
	
	ADD R10, R10, R11		; 				add colour to total colour
	
outOfBounds					; 			}
	
	ADD R9, R9, #1			; 			diagonal count ++
	ADD R2, R2, #1			; 			x ++
	ADD R3, R3, #1			; 			y ++
	
	B for					; 		}
	
endFor

	SUB R2, R2, R0			; 		x - blur radius
	SUB R2, R2, #1			; 		x - 1
	SUB R3, R3, R0			; 		y - blur radius
	SUB R3, R3, #1			; 		y - 1

	LDR R11, =0				; 		Sets the initial quotient to 0
	
while3	

	CMP R10, R1				; 		if( total colour is larger than blur diamater )
	BLO endwhile3			;		{
	
	SUB R10, R10, R1		; 			Subtract colour blur diamater from total colour
	ADD R11, R11, #1		; 			Add 1 to quotient

	B while3				;		}
	
endwhile3
	
	LSL R12, R12, #8		;		shift all colours left
	ADD R12, R12, R11		;		add new colour to end of pixel
	SUB R7, R7, #8			; 		colour count - 8
	
	B while2				; 	}

endWhile2
	
	AND R12, R12, #0x00FFFFFF; 	set first byte in pixel to 00
	MUL R11, R3, R6			; address = y * width
	ADD R11, R11, R2		; address + x
	LSL R11, R11, #2		; addrss * 4
	ADD R11, R4, R11		; address + starting address
	
	STR R12, [R11]			; store pixel in memory at address
	ADD R2, R2, #1			; x ++
	
	B while1				; }
	
endWhile1
	
	BL	putPic				; re-display the updated image

stop	B	stop

	END