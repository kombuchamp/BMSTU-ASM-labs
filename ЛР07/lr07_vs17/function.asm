; �������� ������ � VS
; | Overflow  | OV |
; | Direction | UP |
; | Interrupt | EI |
; | Sign      | PL |
; | Zero      | ZR |
; | Auxiliary | AC |
; | Parity    | PE |
; | Carry     | CY |

.386
.MODEL FLAT, C
	public function
.STACK
.DATA
	SELECTED DD 7
	OPTIONS DD proc0, proc1, proc2, proc3, proc4, proc5, proc6, proc7, proc8
	X DW 0FFFFh
	ARR DB 17 DUP ('+')

	HEXNUMS DB '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' 
.CODE
	function PROC	
		; � EBX ����� ������� ARR. �� ����� ������� ����������� ����� � ����� ������� ����� ������ � ������
		mov ebx, offset arr


		mov eax, SELECTED
		CALL OPTIONS[eax*4]

		ret
	function ENDP
	



	;// ����� ������� ����
	proc0 PROC
		ret
	proc0 ENDP
	
	;// ���� (�� ���������������)
	proc1 PROC
		ret
	proc1 ENDP
	
	;// ����� �� ����� (� ������ �������� � ������)
	;// � ����� ������ �������� �� ������ � � ����� ��������� ������ ��� �����
	;// � ��� ���������� ����� (������������ ������� ������).
	proc2 PROC
		mov bx, x ;//  �����
		mov cx, 16 ;// ������ ������� 
		mov si,0 ;// ������ � ������� ������
		
		jmp output
		counter_decrement:
			dec cx
		output:
			shl bx, 1
			setc al ;// al = CF ? 1 : 0
			; ���������, ���� � �������� 0
			cmp al, 0
			jz check_if_preceding_zero
			jmp actual_output
			; ���������, ���� ��� ���������� ����
			check_if_preceding_zero:
				cmp si, 0
				jz counter_decrement
				jmp proc2_exit
			actual_output:
				add al,'0'
				mov arr[si+1],al ;// �� ������� �������, � ������ ����
				inc si
		loop output

		proc2_exit:

		ret
	proc2 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ �
	;// � ����� ��������� ������ �� ������ � ��� ���������� ����� 
	;// (������������ ������� NEG � ��������� ����������� ������).
	proc3 PROC
		;// ��������� ������� ��� �����
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

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ����������� ������ ��� ����� 
	;// (������������ ������� �������. ����� ������� �� �������).
	proc4 PROC
		;// ������� ���������
		mov eax, 0
		mov ebx, 0
		mov edx, 0
		mov ecx, 0
		
		;// DIV:
		;//	----EDX:EAX - �������
		;//	----EAX - �������
		;//	----EDX - �������

		mov ebx, 10	;// �������� 
		mov ax, x 
		proc4_snap_number:
			mov edx, 0
			div bx
			add edx, '0'
			inc cx
			push edx
			cmp eax, 0
			jne proc4_snap_number

		mov ebx, 1
		proc4_output:
			pop eax
			mov arr[ebx], al
			inc ebx
			loop proc4_output
		

		ret
	proc4 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ����������� ������ �� ������ 
	;// (������������ ������� NEG � ��������� ����������� ������).
	proc5 PROC
		;// ��������� ������� ��� �����
		bt X,15
		setc al
		cmp al, 0
		jz proc5_output
		neg x
		mov arr[0], '-'
		proc5_output:
		call proc4
		ret
	proc5 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ������������������ ������ ��� ����� 
	;// (������������ ������� ������������ ������ � ����������).
	proc6 PROC
		;// ������� ���������
		mov eax, 0
		mov ebx, 0
		mov edx, 0
		mov ecx, 0
		
		;// DIV:
		;//	----EDX:EAX - �������
		;//	----EAX - �������
		;//	----EDX - �������

		mov ebx, 16	;// �������� 
		mov ax, x 
		proc6_snap_number:
			mov edx, 0
			div bx
			inc cx
			push edx
			cmp eax, 0
			jne proc6_snap_number

		mov ebx, 1
		proc6_output:
			pop eax
			mov dl, hexnums[eax]
			mov arr[ebx], dl
			inc ebx
			loop proc6_output
		
		ret
	proc6 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ������������������ ������ �� ������ 
	;// (������������ ������� NEG � ��������� ����������� ������).
	proc7 PROC
		;// ��������� ������� ��� �����
		bt X,15
		setc al
		cmp al, 0
		jz proc7_output
		neg x
		mov arr[0], '-'
		proc7_output:
		call proc6
		ret
	proc7 ENDP

	;// �����
	proc8 PROC
		ret
	proc8 ENDP

END
