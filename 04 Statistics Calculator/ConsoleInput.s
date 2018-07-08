	AREA	ConsoleInput, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	MOV R4, #10						; set R4 to 10
	MOV R5, #0						; set initial value to 0
	
firstNumber
	
	BL getkey						; read key from console
	
	CMP R0, #0x20  					; while (key != SPACE)
	BEQ endFirstNumber				; {
	
	CMP R0, #0x0D					; 	if (key != CR)
	BEQ onlyOneNumber				; 	{
	
	BL sendchar						;  		echo key back to console
	SUB R0, R0, #'0'				;		convert key into decimal
	MUL R5, R4, R5					; 		multiply value by 10
	ADD R5, R5, R0					;		add key to value
	
	B firstNumber					; 	}
	
onlyOneNumber						; }
	
	B onlyOneNumberEnd
	
endFirstNumber
	
	BL sendchar						; echo key back to console

read

	BL getkey						; read key from console
	
	CMP R0, #0x0D  					; while (key != CR)
	BEQ endRead						; {
	
	CMP R0, #0x20					; 	if (key != SPACE)
	BEQ newNumber					;	{
	
	BL sendchar						;  		echo key back to console
	SUB R0, R0, #'0'				;		convert key into decimal
	MUL R5, R4, R5					; 		multiply value by 10
	ADD R5, R5, R0					;		add key to value
	
	B read							; 	}
	
newNumber

	BL sendchar						;	echo key back to console
	MOV R5, #0						;	reset value
	B read							; }
	
onlyOneNumberEnd

endRead								;

stop	B	stop

	END