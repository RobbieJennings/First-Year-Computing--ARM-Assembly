	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	MOV R4, #10						; set R4 to 10
	MOV R5, #0						; set initial value to 0
	MOV R6, #0						; set initial count to 0
	MOV R7, #0						; set initial sum to 0
	MOV R8, #0						; set initial min to 0
	MOV R9, #0						; set initial max to 0
	MOV R10, #0						; set initial mean to 0
	
firstNumber
	
	BL getkey						; read key from console
	
	CMP	R0, #0x20  					; while (key != SPACE)
	BEQ	endFirstNumber				; {
	
	CMP R0, #0x0D					; 	if (key != CR)
	BEQ onlyOneNumber				; 	{
	
	BL	sendchar					;  		echo key back to console
	SUB R0, R0, #'0'				;		convert key into decimal
	MUL R5, R4, R5					; 		multiply value by 10
	ADD R5, R5, R0					;		add key to value
	
	B firstNumber					; 	}
	
onlyOneNumber						; }

	ADD R6, R6, #1					; add 1 to count
	ADD R7, R7, R5					; set sum to value
	MOV R8, R5						; set max to value
	MOV R9, R5						; set min to value
	
	B onlyOneNumberEnd
	
endFirstNumber
		
	ADD R6, R6, #1					; add 1 to count
	ADD R7, R7, R5					; set sum to value
	MOV R8, R5						; set max to value
	MOV R9, R5						; set min to value
	MOV R5, #0						; reset value
	
	BL sendchar						; echo key back to console

read

	BL	getkey						; read key from console
	
	CMP	R0, #0x0D  					; while (key != CR)
	BEQ	endRead						; {
	
	CMP R0, #0x20					; 	if (key != SPACE)
	BEQ newNumber					;	 {
	
	BL	sendchar					;  		echo key back to console
	SUB R0, R0, #'0'				;		convert key into decimal
	MUL R5, R4, R5					; 		multiply value by 10
	ADD R5, R5, R0					;		add key to value
	
	B read							; 	}
	
newNumber

	BL sendchar						; 	echo key back to console

	CMP R5, R8						;	if (value < min)
	BHI minNumber					;	{
	
	MOV R8, R5						;		set min to value
	
minNumber							;	}

	CMP R5, R9						; 	if (value > max)
	BLO maxNumber					;	{
	
	MOV R9, R5						;		set max to value
	
maxNumber							;	}

	ADD R7, R7, R5					;	add value to total
	MOV R5, #0						;	reset value
	ADD R6, R6, #1					;	add 1 to count
	
	B	read						; }
		
endRead

	CMP R5, R8						; if (value < min)
	BHI minNumber2					; {
	
	MOV R8, R5						;	set min to value
	
minNumber2							; }

	CMP R5, R9						; if (value > max)
	BLO maxNumber2					; {
	
	MOV R9, R5						;	set max to value
	
maxNumber2							; }
	
	ADD R6, R6, #1					; add 1 to count
	ADD R7, R7, R5					; add value to total
	
onlyOneNumberEnd

	MOV R11, R7						; set initial sum for calculating mean
	MOV R12, R6						; set inital count for calculating mean

mean	

	CMP R11, R12					; while (sum >= count)
	BLO endMean						; {
	SUB R11, R11, R12				; 	Subtract count from sum
	ADD R10, R10, #1				; 	Add 1 to mean

	B mean							; }
	
endMean

stop	B	stop

	END