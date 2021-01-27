.386
.MODEL FLAT, C
	public function
.STACK
.DATA
	SELECTED DD 4
	OPTIONS DD proc0, proc1, proc2, proc3, proc4, proc5, proc6, proc7, proc8
	X DW 0000Fh
	ARR DB 16 DUP ('+')

.CODE
	function PROC	
		; В EBX адрес массива ARR. Во время отладки скопировать адрес и таким образом найти массив в памяти
		mov ebx, offset arr


		mov eax, SELECTED
		CALL OPTIONS[eax*4]

		ret
	function ENDP
	



	;// Вывод пунктов меню
	proc0 PROC
		ret
	proc0 ENDP
	
	;// ввод (не рассматривается)
	proc1 PROC
		ret
	proc1 ENDP
	
	;// вывод на экран (в массив символов в памяти)
	;// с новой строки значения из ячейки Х в форме двоичного целого без знака
	;// и без лидирующих нулей (использовать команды сдвига).
	proc2 PROC
		mov bx, x ;//  число
		mov cx, 16 ;// Размер массива 
		mov si,0 ;// Индекс в массиве вывода
		
		jmp output
		counter_decrement:
			dec cx
		output:
			shl bx, 1
			setc al ;// al = CF ? 1 : 0
			; Проверяем, если в переносе 0
			cmp al, 0
			jz check_if_preceding_zero
			jmp actual_output
			; Проверяем, если это лидирующий ноль
			check_if_preceding_zero:
				cmp si, 0
				jz counter_decrement
			actual_output:
				add al,'0'
				mov arr[si+1],al ;// со второго символа, в первом знак
				inc si
		loop output



		ret
	proc2 ENDP

	;// вывод на экран с новой строки значения из ячейки Х
	;// в форме двоичного целого со знаком и без лидирующих нулей 
	;// (использовать команду NEG и процедуру предыдущего пункта).
	proc3 PROC
		;// Проверяем старший бит числа
		bt X,15
		setc al
		cmp al, 0
		jz proc3_output
		neg x
		mov arr[0], '-'
		proc3_output:
		call proc2


		ret
	proc3 ENDP

	;// вывод на экран с новой строки значения из ячейки Х 
	;// в форме десятичного целого без знака 
	;// (использовать команду деления. через остаток от деления).
	proc4 PROC
		mov ax, x
		mov dx, 0
		mov cx, 10
		div cx

		ret
	proc4 ENDP

	;// вывод на экран с новой строки значения из ячейки Х 
	;// в форме десятичного целого со знаком 
	;// (использовать команду NEG и процедуру предыдущего пункта).
	proc5 PROC
		ret
	proc5 ENDP

	;// вывод на экран с новой строки значения из ячейки Х 
	;// в форме шестнадцатеричного целого без знака 
	;// (использовать команды циклического сдвига и конъюнкции).
	proc6 PROC
		ret
	proc6 ENDP

	;// вывод на экран с новой строки значения из ячейки Х 
	;// в форме шестнадцатеричного целого со знаком 
	;// (использовать команду NEG и процедуру предыдущего пункта).
	proc7 PROC
		ret
	proc7 ENDP

	;// выход
	proc8 PROC
		ret
	proc8 ENDP

END
