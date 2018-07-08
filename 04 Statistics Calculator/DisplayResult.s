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

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R0, #0x7C					; set key to |
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R0, #0x43					; set key to C
	BL sendchar						; echo key back to console
	
	MOV R0, #0x6F					; set key to o
	BL sendchar						; echo key back to console
	
	MOV R0, #0x75					; set key to u
	BL sendchar						; echo key back to console
	
	MOV R0, #0x6E					; set key to n
	BL sendchar						; echo key back to console
	
	MOV R0, #0x74					; set key to t
	BL sendchar						; echo key back to console
	
	MOV R0, #0x3A					; set key to :
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R5, #0						; set R0 to 0
	MOV R11, R6						; set R11 to count
	MOV R12, #0						; set R12 to 0
	
singleDigitCalculation1	

	CMP R11, #10					; while (count >= 10)
	BLO endSingleDigitCalculation1	; {
	SUB R11, R11, #10				;  	sub 10 from count
	ADD R5, R5, #1					;	add 1 to R5
	
	B singleDigitCalculation1		; }
	
endSingleDigitCalculation1
	
	CMP R5, #0						; if (R5 /= 0)
	BEQ singleDigit1				; {

	MOV R5, #0						; set R5 to 0
	MOV R11, R6						; set R11 to count
	MOV R12, #0						; set R12 to 0
	
digitCalculation1	

	CMP R11, #10					; while (count <= 10)
	BLO endDigitCalculation1		; {
	SUB R11, R11, #10				;	sub 10 from count
	ADD R5, R5, #1					;	add 1 to R5
	
	B digitCalculation1				; }
		
endDigitCalculation1
	
	MOV R11, R5						; set count to R5
	ADD R12, #1						; add 1 to R12	
	MOV R5, #0						; set R5 to 0
	
	CMP R11, #10					; if (count >= 10)
	BHS digitCalculation1			; return to while loop
	
	MOV R11, #10					; set R11 to 10
	MOV R5, #1						; set R5 to 1
	
initialPower1

	CMP R12, #0						; While (R12 /= 0)
	BEQ endInitialPower1			; {
	MUL R5, R11, R5					;	multiply R5 by R11
	SUB R12, R12, #1				;	subtract 1 from R12
	B initialPower1					; }
	
endInitialPower1

	MOV R0, #0						; set R0 to 0
	MOV R12, R5						; set R12 to R5
	MOV R11, R6						; set R11 to count
	
	B multipleDigits1				; skip to multipleDigits1
	
singleDigit1
	
	MOV R0, #0						; set R0 to 0
	MOV R12, #1						; set R12 to 1
	MOV R11, R6						; set R11 to count
	
multipleDigits1						; }

output1

	MOV R5, #0						; reset R5
	
	CMP R11, R12					; while (count >= R12)
	BLO endDigit1					; {
	SUB R11, R11, R12				;  	subtract R12 from count
	ADD R0, R0, #1					;   add 1 to R0
	
	B output1						; }
	
endDigit1

	ADD R0, R0, #'0'				; convert key to ASCII character
	BL sendchar						; echo key back to console
	
	SUB R0, #'0'					; reset key to hexadecimal
	
	CMP R12, #10					; while (key != 0)
	BLO endOutput1					; {
	
reducePower1	

	CMP R12, R4						; 	while (key >= 10)
	BLO endNextDigit1				; 	{
	SUB R12, R12, R4				;		sub 10 from key
	ADD R5, R5, #1					;		add 1 to R5
	
	B reducePower1					;	}
	
endNextDigit1

	MOV R0, #0						;	reset key
	MOV R12, R5						;	set R12 to R5
	
	B output1						; }
	
endOutput1

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R0, #0x7C					; set key to |
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R0, #0x53					; set key to S
	BL sendchar						; echo key back to console
	
	MOV R0, #0x75					; set key to u
	BL sendchar						; echo key back to console
	
	MOV R0, #0x6D					; set key to m
	BL sendchar						; echo key back to console
	
	MOV R0, #0x3A					; set key to :
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R5, #0						; set R5 to 0
	MOV R11, R7						; set R11 to sum
	MOV R12, #0						; set R12 to 0

singleDigitCalculation2	

	CMP R11, #10					; while (sum >= 10)
	BLO endSingleDigitCalculation2	; {
	SUB R11, R11, #10				;  	sub 10 from sum
	ADD R5, R5, #1					;	add 1 to R5
	
	B singleDigitCalculation2		; }
	
endSingleDigitCalculation2
	
	CMP R5, #0						; if (R5 /= 0)
	BEQ singleDigit2				; {

	MOV R5, #0						; set R5 to 0
	MOV R11, R7						; set R11 to sum
	MOV R12, #0
	
digitCalculation2	

	CMP R11, #10					; while (sum <= 10)
	BLO endDigitCalculation2		; {
	SUB R11, R11, #10				;  	sub 10 from sum
	ADD R5, R5, #1					; 	add 1 to R5
	
	B digitCalculation2				; }
		
endDigitCalculation2
	
	MOV R11, R5						; set sum to R5
	ADD R12, #1						; add 1 to R12
	MOV R5, #0						; set R5 to 0
	
	CMP R11, #10					; if (sum > 10)
	BHS digitCalculation2			; return to while loop
	
	MOV R11, #10					; set R11 to 10
	MOV R5, #1						; set R5 to 1
	
initialPower2

	CMP R12, #0						; while (R12 /= 0)
	BEQ endInitialPower2			; {
	MUL R5, R11, R5					; 	multiply R5 by sum
	SUB R12, R12, #1				; 	subtract one from R12
	B initialPower2					; }
	
endInitialPower2

	MOV R0, #0						; set R0 to 0
	MOV R12, R5						; set R12 to R5
	MOV R11, R7						; set R11 to sum
	
	B multipleDigits2				; skip to multipleDigits2
	
singleDigit2						
		
	MOV R0, #0						; set R0 to 0
	MOV R12, #1						; set R12 to 1
	MOV R11, R7						; set R11 to sum
	
multipleDigits2						; }

output2

	MOV R5, #0						; reset R5
	
	CMP R11, R12					; while (sum >= R12)
	BLO endDigit2					; {
	SUB R11, R11, R12				;  	sub R12 from sum
	ADD R0, R0, #1					;   add 1 to R0
	
	B output2						; }
	
endDigit2

	ADD R0, R0, #'0'				; convert key to ASCII character
	BL sendchar						; echo key back to console
		
	SUB R0, #'0'					; reset key to hexadecimal
	
	CMP R12, #10					; while key != 0
	BLO endOutput2					; {
	
reducePower2	

	CMP R12, R4						; 	while (key >= 10)
	BLO endNextDigit2				; 	{
	SUB R12, R12, R4				;		sub 10 from key
	ADD R5, R5, #1					;		add 1 to R5
	
	B reducePower2					;	}
	
endNextDigit2

	MOV R0, #0						;	reset key
	MOV R12, R5						;	set R12 to R5
	
	B output2						; }
	
endOutput2

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R0, #0x7C					; set key to |
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R0, #0x4D					; set key to M
	BL sendchar						; echo key back to console
	
	MOV R0, #0x69					; set key to i
	BL sendchar						; echo key back to console
	
	MOV R0, #0x6E					; set key to n
	BL sendchar						; echo key back to console
	
	MOV R0, #0x3A					; set key to :
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R5, #0						; set R0 to 0
	MOV R11, R8						; set R11 to sum
	MOV R12, #0
	
singleDigitCalculation3	

	CMP R11, #10					; while (min >= 10)
	BLO endSingleDigitCalculation3	; {
	SUB R11, R11, #10				;  	subtract 10 from min
	ADD R5, R5, #1					;  	add 1 to R5
	
	B singleDigitCalculation3		; }
	
endSingleDigitCalculation3
	
	CMP R5, #0						; if (R5 /= 0)
	BEQ singleDigit3				; {

	MOV R5, #0						; set R0 to 0
	MOV R11, R8						; set R11 to min
	MOV R12, #0						; set R12 to 0
	
digitCalculation3	

	CMP R11, #10					; while (min <= 10)
	BLO endDigitCalculation3		; {
	SUB R11, R11, #10				;  	subtract 10 from min
	ADD R5, R5, #1					;	add 1 to R5
	
	B digitCalculation3				; }
		
endDigitCalculation3
	
	MOV R11, R5						; set min to R5
	ADD R12, #1						; add 1 to R12
	MOV R5, #0						; set R5 to 0
	
	CMP R11, #10					; if (min >= 10)
	BHS digitCalculation3			; return to while loop
	
	MOV R11, #10					; set R11 to 10
	MOV R5, #1						; set R5 to 1
	
initialPower3

	CMP R12, #0						; while (R12 /= 0)
	BEQ endInitialPower3			; {
	MUL R5, R11, R5					;	Multiply R5 by R11
	SUB R12, R12, #1				; 	Subtract one from R12
	B initialPower3					; }
	
endInitialPower3

	MOV R0, #0						; set R0 to 0
	MOV R12, R5						; set R12 to R5
	MOV R11, R8						; set R11 to max
	
	B multipleDigits3				; skip to multipleDigits3

singleDigit3							
	
	MOV R0, #0						; set R0 to 0
	MOV R12, #1						; set R12 to 1
	MOV R11, R8						; set R11 to max
	
multipleDigits3						; }

output3

	MOV R5, #0						; reset R5
	
	CMP R11, R12					; while (min >= R12)
	BLO endDigit3					; {
	SUB R11, R11, R12				;  	subtract R12 from min
	ADD R0, R0, #1					;   add 1 to R0
	
	B output3						; }
	
endDigit3

	ADD R0, R0, #'0'				; convert key to ASCII character
	BL sendchar						; echo key back to console
	
	SUB R0, #'0'					; reset key to hexadecimal
	
	CMP R12, #10					; while (key != 0)
	BLO endOutput3					; {
	
reducePower3	

	CMP R12, R4						; 	while (key >= 10)
	BLO endNextDigit3				; 	{
	SUB R12, R12, R4				;		subtract 10 from key
	ADD R5, R5, #1					;		add 1 to R5
	
	B reducePower3					;	}

endNextDigit3

	MOV R0, #0						;	reset key
	MOV R12, R5						;	set R12 to R5
	
	B output3						; }
	
endOutput3

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R0, #0x7C					; set key to |
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R0, #0x4D					; set key to M
	BL sendchar						; echo key back to console
	
	MOV R0, #0x61					; set key to a
	BL sendchar						; echo key back to console
	
	MOV R0, #0x78					; set key to x
	BL sendchar						; echo key back to console
	
	MOV R0, #0x3A					; set key to :
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R5, #0						; set R0 to 0
	MOV R11, R9						; set R11 to max
	MOV R12, #0
	
singleDigitCalculation4	

	CMP R11, #10					; while (max >= 10)
	BLO endSingleDigitCalculation4	; {
	SUB R11, R11, #10				;  	subtract 10 from max
	ADD R5, R5, #1					;	add 1 to R5
	
	B singleDigitCalculation4		; }
	
endSingleDigitCalculation4
	
	CMP R5, #0						; if (R5 /= 0)
	BEQ singleDigit4				; {

	MOV R5, #0						; set R0 to 0
	MOV R11, R9						; set R11 to max
	MOV R12, #0						; set R12 to 0
	
digitCalculation4	

	CMP R11, #10					; while (max <= 10)
	BLO endDigitCalculation4		; {
	SUB R11, R11, #10				;  	subtract 10 from max
	ADD R5, R5, #1					;	add 1 to R5
	
	B digitCalculation4				; }
		
endDigitCalculation4
	
	MOV R11, R5						; set max to R5
	ADD R12, #1						; add 1 to R12
	MOV R5, #0						; set R5 to 0
	
	CMP R11, #10					; if (max >= 10)
	BHS digitCalculation4			; return to while loop
	
	MOV R11, #10					; set R11 to 10
	MOV R5, #1						; set R5 to 1
	
initialPower4

	CMP R12, #0						; while (R12 /= 0)
	BEQ endInitialPower4			; {
	MUL R5, R11, R5					;	multiply R5 by R11
	SUB R12, R12, #1				;	subtract 1 from R12
	B initialPower4					; }
	
endInitialPower4

	MOV R0, #0						; set R0 to 0
	MOV R12, R5						; set R12 to R5
	MOV R11, R9						; set R11 to max
	
	B multipleDigits4				; skip to multipleDigits4
	
singleDigit4
		
	MOV R0, #0						; set R0 to 0						
	MOV R12, #1						; set R12 to 1
	MOV R11, R9						; set R11 to max
	
multipleDigits4						; }

output4

	MOV R5, #0						; reset R5
	
	CMP R11, R12					; while (max >= R12)
	BLO endDigit4					; {
	SUB R11, R11, R12				;  	subtract R12 from max
	ADD R0, R0, #1					;  	add 1 to R0
	
	B output4						; }
	
endDigit4

	ADD R0, R0, #'0'				; convert key to ASCII character
	BL sendchar						; echo key back to console
	
	SUB R0, #'0'					; reset key to hexadecimal
	
	CMP R12, #10					; while key != 0
	BLO endOutput4					; {
	
reducePower4	

	CMP R12, R4						; 	while (key >= 10)
	BLO endNextDigit4				; 	{
	SUB R12, R12, R4				;		subtract 10 from key
	ADD R5, R5, #1					;		add 1 to R5
	
	B reducePower4					;	}
	
endNextDigit4

	MOV R0, #0						;	reset key
	MOV R12, R5						;	set R12 to R5
	
	B output4						; }
	
endOutput4

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console
	
	MOV R0, #0x7C					; set key to |
	BL sendchar						; echo key back to console
	
	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R0, #0x4D					; set key to M
	BL sendchar						; echo key back to console
	
	MOV R0, #0x65					; set key to e
	BL sendchar						; echo key back to console
	
	MOV R0, #0x61					; set key to a
	BL sendchar						; echo key back to console
	
	MOV R0, #0x6E					; set key to n
	BL sendchar						; echo key back to console
	
	MOV R0, #0x3A					; set key to :
	BL sendchar						; echo key back to console

	MOV R0, #0x20					; set key to SPACE
	BL sendchar						; echo key back to console

	MOV R5, #0						; set R0 to 0
	MOV R11, R10					; set R11 to mean
	MOV R12, #0
	
singleDigitCalculation5	

	CMP R11, #10					; while (mean >= 10)
	BLO endSingleDigitCalculation5	; {
	SUB R11, R11, #10				;  	subtract 10 from mean
	ADD R5, R5, #1					;	add 1 to R5
	
	B singleDigitCalculation5		; }
	
endSingleDigitCalculation5
	
	CMP R5, #0						; if (R5 /= 0)
	BEQ singleDigit5				; {

	MOV R5, #0						; set R5 to 0
	MOV R11, R10					; set R11 to mean
	MOV R12, #0						; set R12 to 0
	
digitCalculation5	

	CMP R11, #10					; while (count >= 10)
	BLO endDigitCalculation5		; {
	SUB R11, R11, #10				;  	subtract 10 from count
	ADD R5, R5, #1					;	add 1 to R5
	
	B digitCalculation5				; }
		
endDigitCalculation5
	
	MOV R11, R5						; set mean to R5
	ADD R12, #1						; add 1 to R12
	MOV R5, #0						; set R5 to 0
	
	CMP R11, #10					; if (R11 >= 10)
	BHS digitCalculation5			; return to while loop
	
	MOV R11, #10					; set R11 to 10
	MOV R5, #1						; set R5 to 0
	
initialPower5

	CMP R12, #0						; while (R12 /= 0)
	BEQ endInitialPower5			; {
	MUL R5, R11, R5					;	Multiply R5 by R11
	SUB R12, R12, #1				;	Subtract 1 from R12
	B initialPower5					; }
	
endInitialPower5

	MOV R0, #0						; set R0 to 0
	MOV R12, R5						; set R12 to R5
	MOV R11, R10					; set R11 to mean
	
	B multipleDigits5				; skip to multipleDigits5
	
singleDigit5							
				
	MOV R0, #0						; set R0 to 0	
	MOV R12, #1						; set R12 to 1
	MOV R11, R10					; set R11 to mean
	
multipleDigits5						; }

output5

	MOV R5, #0						; reset R5
	
	CMP R11, R12					; while (mean >= R12)
	BLO endDigit5					; {
	SUB R11, R11, R12				;  	sub R12 from mean
	ADD R0, R0, #1					;   add 1 to R0
	
	B output5						; }
	
endDigit5
	
	ADD R0, R0, #'0'				; convert key to ASCII character
	BL sendchar						; echo key back to console
	
	SUB R0, #'0'					; reset key to hexadecimal
	
	CMP R12, #10					; while (key != 0)
	BLO endOutput5					; {
	
reducePower5	

	CMP R12, R4						; 	while (key >= 10)
	BLO endNextDigit5				; 	{
	SUB R12, R12, R4				;		subtract 10 from key
	ADD R5, R5, #1					;		add 1 to R5
	
	B reducePower5					;	}
	
endNextDigit5

	MOV R0, #0						;	reset key
	MOV R12, R5						;	set R12 to R5
	
	B output5						; }
	
endOutput5

stop	B	stop

	END