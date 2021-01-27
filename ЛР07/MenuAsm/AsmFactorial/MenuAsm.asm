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
			actual_output:
				add al,'0'
				mov arr[si+1],al ;// �� ������� �������, � ������ ����
				inc si
		loop output



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
		mov ax, x
		mov dx, 0
		mov cx, 10
		div cx

		ret
	proc4 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ����������� ������ �� ������ 
	;// (������������ ������� NEG � ��������� ����������� ������).
	proc5 PROC
		ret
	proc5 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ������������������ ������ ��� ����� 
	;// (������������ ������� ������������ ������ � ����������).
	proc6 PROC
		ret
	proc6 ENDP

	;// ����� �� ����� � ����� ������ �������� �� ������ � 
	;// � ����� ������������������ ������ �� ������ 
	;// (������������ ������� NEG � ��������� ����������� ������).
	proc7 PROC
		ret
	proc7 ENDP

	;// �����
	proc8 PROC
		ret
	proc8 ENDP

END
