SSTACK     SEGMENT PARA STACK  'STACK'
                DB   64 DUP('00000000')
SSTACK     ENDS

     DSEG          SEGMENT  PARA PUBLIC 'DATA'
     N				DW   0005h
	 X         		DB   11, 12, 13, 14, 15,21, 22, 23, 24, 25,31, 32, 33, 34, 35,41, 42, 43, 44, 45,51, 52, 53, 54, 55
     DSEG       	ENDS

	 
     CSEG   	SEGMENT PARA PUBLIC 'CODE'
				ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

     START  	PROC FAR
				MOV AX,DSEG
				MOV DS,AX
				
				MOV SI,OFFSET X
				MOV DI,OFFSET X
				ADD SI,1
				ADD DI,N
				
				MOV DX,0
				MOV CX,0
				
				MOV BX,0
				ADD DX, N
				SUB DX, 1
				
				SUB X, 11
				SUB N, 1 ; Не могу записать N-1 в CMP
				
			outer_loop:
				CMP BX,N
				JE end_loop
				
				SUB DX, BX
				inner_loop:
					
					CMP CX, DX
					JE after_inner_loop
					ADD CX, 1
					
					;_____;
					
					INC X
					;_____;
					
					JMP inner_loop
				
				after_inner_loop:
					MOV CX,0
					MOV DX,N
					ADD BX,1
					JMP outer_loop
			end_loop:
				
				
				
			
			;;;;;;;;;;;;;;;; 
				MOV  AH,4CH
				MOV  AL,0
				INT 21H
     START  	ENDP

     CSEG      ENDS
               END  START
