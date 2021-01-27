// ConsoleApplication1.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>
using namespace std;


char X[5][5] = {{1,2,3,4,5},
{1,2,3,4,5},
{1,2,3,4,5},
{1,2,3,4,5},
{1,2,3,4,5}};
const char N = 5;
char CNT = N - 1;


void print_out(char iter[5][5])
{
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			cout << (int)iter[i][j] << " ";
		}
		cout << endl;
	}
	cout << endl;
}

int _tmain(int argc, _TCHAR* argv[])
{
	print_out(X);

	_asm
	{

		; CNT = N-1
			;MOV CNT, 5 ; Нельзя поставить N
			;DEC CNT

			; Указатели на горизонтальный и вертикальный элемент матрицы
			MOV ESI,OFFSET X
			MOV EDI,OFFSET X
			ADD ESI,1
			ADD EDI,5 ;N


			MOV EDX, 4;N-1

			MOV EBX,0 ; Внешний счетчик
			MOV ECX,0 ; Внутренний счетчик

			
outer_loop:
		CMP EBX, 4;CNT
			JE end_loop

			SUB EDX, EBX
inner_loop:

		CMP ECX, EDX
			JE after_inner_loop
			ADD ECX, 1

			;_____;
		;mov al,[esi]
		XCHG al, [ESI]
		XCHG al, [EDI]
		XCHG al, [ESI]

			INC ESI
			ADD EDI, 5;N

			;_____;

		JMP inner_loop

after_inner_loop:
		;перескочили на один шаг
			DEC ESI
			SUB EDI, 5;N

			; смещаем ряд
			ADD ESI, 3  ;(3 + i) - 1
			ADD ESI, EBX
			;DEC ESI

			MOV EAX, 3
			SUB EAX, EBX
			MOV ECX, 5;N
MULTIP:
		SUB EDI, EAX
			LOOP MULTIP
			ADD EDI, 1     ;(1 - N * (3 - i)) 
			add edi, 5 ;;;;;;!!!

			;Сброс внутреннего счетчика
			MOV ECX,0
			;Инкремент наружного счетчика
			INC EBX
			;Сброс DX
			MOV EDX, 4;CNT


			JMP outer_loop
end_loop:


	}


	print_out(X);

	system("pause");
	return 0;
}

