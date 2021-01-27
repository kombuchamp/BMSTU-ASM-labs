.386
.MODEL FLAT, C
	public factorial
.STACK
.DATA
.CODE
	factorial PROC
		push ebp		; Сохраняем старый указатель на фрейм стека
		mov ebp, esp	; Создаем новый фрейм стека

		; Сохраняем регистры в стек (eax, edx, ecx и тд можно не сохранять)
		push esi
		push edi
		; Забираем аргументы
		mov esi, [ebp+8]		; Число, от которого требуется взять факториал
		mov edi, [ebp+12]		; Адрес переменной, в которую пойдет результат
		
		;__________________________________________________________________________;
		; Передача аргументов через регистры
		mov eax, 1 ; Аккумулятор
		mov ecx, esi ; Число, от которого факториал
		
		call factorial_helper

		mov [edi], eax
		
		;__________________________________________________________________________;

		; Восстанавливаем регистры и возвращаемся
		pop edi
		pop esi
		pop ebp
		ret
	factorial ENDP

	; Вспомогательная рекурсивная функция.
	; Аргументы:
	;_; EAX - Аккумулятор
	;_; ECX - N
	factorial_helper PROC NEAR
		; Базовый случай
		cmp ecx, 1
		jle exit
		
		; Рекурсивный случай
		imul eax, ecx
		dec ECX
		call factorial_helper

	exit:
		ret
	factorial_helper ENDP

END
