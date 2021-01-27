.386
.MODEL FLAT, C
	public factorial
.STACK
.DATA
.CODE
	factorial PROC
		push ebp		; ��������� ������ ��������� �� ����� �����
		mov ebp, esp	; ������� ����� ����� �����

		; ��������� �������� � ���� (eax, edx, ecx � �� ����� �� ���������)
		push esi
		push edi
		; �������� ���������
		mov esi, [ebp+8]		; �����, �� �������� ��������� ����� ���������
		mov edi, [ebp+12]		; ����� ����������, � ������� ������ ���������
		
		;__________________________________________________________________________;
		; �������� ���������� ����� ��������
		mov eax, 1 ; �����������
		mov ecx, esi ; �����, �� �������� ���������
		
		call factorial_helper

		mov [edi], eax
		
		;__________________________________________________________________________;

		; ��������������� �������� � ������������
		pop edi
		pop esi
		pop ebp
		ret
	factorial ENDP

	; ��������������� ����������� �������.
	; ���������:
	;_; EAX - �����������
	;_; ECX - N
	factorial_helper PROC NEAR
		; ������� ������
		cmp ecx, 1
		jle exit
		
		; ����������� ������
		imul eax, ecx
		dec ECX
		call factorial_helper

	exit:
		ret
	factorial_helper ENDP

END
