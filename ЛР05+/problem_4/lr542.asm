PUBLIC EXTRNLBL
EXTRN X:BYTE

DSEG2 SEGMENT PARA PUBLIC 'DATA2'
	PUBLIC Y
	Y DB 'Y'
DSEG2 ENDS

CSEG2 SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CSEG2,DS:DSEG2
	EXTRNLBL:
		MOV AX, DSEG2
		mov DS, AX
		MOV AH, X
		MOV AL, Y
		MOV X, AL
		MOV Y, AH
		
		MOV AH, 2
		MOV DL, X
		INT 21h
		
		
		
		MOV ah, 4ch
		MOV al, 0
		INT 21h

CSEG2 ENDS
END