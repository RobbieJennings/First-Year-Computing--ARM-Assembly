	AREA	Adjust, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start

start

	LDR R2, =0				; load brightness
	LDR R3, =16				; load contrast

	BL	getPicAddr			; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight		; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth			; load the width of the image (columns) in R6
	MOV	R6, R0
	
	MUL R7, R5, R6			; get size of image
	LDR R8, =0				; set pixel count to 0
	
	CMP R3, #0				; if( contrast < 0 )
	BGT while1
	
	LDR R3, =16				; 	contrast = 16
	
while1
	
	CMP R8, R7				; while( pixel count < size of image )
	BHS endWhile1			; {
	
	LDR R9, =0				; 	colour count = 0
	LDR R0, [R4]			; 	load pixel from memory
	
while2

	CMP R9, #3				; 	while( colour count < 3 )
	BHS endWhile2			;	{
	
	AND R10, R0, #0x00FF0000; 		get individual colour
	LSR R10, R10, #16		; 		shift colour to end of word
	
	MUL R10, R3, R10		; 		colour x contrast
	LSR R10, R10, #4		; 		colour / 16
	ADD R10, R10, R2		; 		colour + brightness
	
	CMP R10, #255			; 		if( colour > 255 )
	BLE highCheck			; 		{
	
	LDR R10, =255			; 			colour = 255

highCheck					; 		}

	CMP R10, #0				;		if( colour < 0 )
	BGE lowCheck			; 		{
	
	LDR R10, =0				; 			colour = 0

lowCheck					; 		}
	
	LSL R0, R0, #8			; 		shift all colours left
	ADD R0, R0, R10			;		add new colour to end of pixel
	ADD R9, R9, #1			; 		colour count ++
	
	B while2				; 	}

endWhile2
	
	AND R0, R0, #0x00FFFFFF	; 	set first byte in pixel to 00
	STR R0, [R4]			; 	store pixel in memory
	
	ADD R8, R8, #1			; 	pixel count ++
	ADD R4, R4, #4			; 	memory address ++
	B while1				; }
	
endWhile1

	BL	putPic				; re-display the updated image

stop	B	stop

	END