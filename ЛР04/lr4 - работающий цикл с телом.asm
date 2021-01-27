SSTACK     SEGMENT PARA STACK  'STACK'
                DB   64 DUP('00000000')
SSTACK     ENDS

     DSEG          SEGMENT  PARA PUBLIC 'DATA'
     N				DW   0005h
	 X         		DB   11, 12, 13, 14, 15,21, 22, 23, 24, 25,31, 32, 33, 34, 35,41, 42, 43, 44, 45,51, 52, 53, 54, 55
	 CNT			DW	 ?
     DSEG       	ENDS

	 
     CSEG   	SEGMENT PARA PUBLIC 'CODE'
				ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

     START  	PROC FAR
				MOV AX,DSEG
				MOV DS,AX
				
				; CNT = N-1
				MOV CNT, 5 ; Нельзя поставить N
				DEC CNT
				
				; Указатели на горизонтальный и вертикальный элемент матрицы
				MOV SI,OFFSET X
				MOV DI,OFFSET X
				ADD SI,1
				ADD DI,N
				
				
				MOV DX, CNT
				
				MOV BX,0 ; Внешний счетчик
				MOV CX,0 ; Внутренний счетчик
				
				;SUB X, 11 ; для отладки
				
			outer_loop:
				CMP BX, CNT
				JE end_loop
				
				SUB DX, BX
				inner_loop:
					
					CMP CX, DX
					JE after_inner_loop
					ADD CX, 1
					
					;_____;
					MOV AH, [SI]
					MOV AL, [DI]
					MOV [SI], AL
					MOV [DI], AH
					
					INC SI
					ADD DI, N
					
					;INC X ; для отладки
					;_____;
					
					JMP inner_loop
				
				after_inner_loop:
					;перескочили на один шаг
					DEC SI
					SUB DI, N
					
					; смещаем ряд
					ADD SI, 3  ;(3 + i) - 1
					ADD SI, BX
					DEC SI
					
					MOV AX, 3
					SUB AX, BX
					MOV CX, N
					MULTIP:
						SUB DI, AX
					LOOP MULTIP
					ADD DI, 1     ;(1 - N * (3 - i)) 
					
					;Сброс внутреннего счетчика
					MOV CX,0
					;Инкремент наружного счетчика
					INC BX
					;Сброс DX
					MOV DX, CNT
					
					
					JMP outer_loop
			end_loop:
				
				
				
			
			;;;;;;;;;;;;;;;; 
				MOV  AH,4CH
				MOV  AL,0
				INT 21H
     START  	ENDP

     CSEG      ENDS
               END  START
