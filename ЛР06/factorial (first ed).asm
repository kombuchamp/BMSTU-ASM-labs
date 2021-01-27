.386
.MODEL FLAT, C
	public factorial
.STACK
.DATA
.CODE
	factorial PROC
		push ebp		; Сохраняем старый указатель на фрейм стека
		mov ebp, esp	; Создаем новый фрейм стека

		; Сохраняем регистры в стек
		push esi
		push edi
		push eax
		; Забираем аргументы
		mov esi, [ebp+8]		; Число, от которого требуется взять факториал
		mov edi, [ebp+12]		; Адрес переменной, в которую пойдет результат
		
		;__________________________________________________________________________;
		
		; Проверка базового случая
		mov eax, esi
		cmp eax, 1
		jle exit


		imul eax, [edi]
		mov [edi], eax
		; Рекурсивный вызов
		dec esi
		push edi
		push esi
		call factorial

		add esp, 8		; Очистка стека от аргументов

		;__________________________________________________________________________;

		; Восстанавливаем регистры и возвращаемся
	exit:
		pop eax
		pop edi
		pop esi
		pop ebp
		ret
	factorial ENDP
END
