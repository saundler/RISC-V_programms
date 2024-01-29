.include "macro-syscalls.m"

.global log_2

.text
log_2:
push(t4)
if:
	li 		t4 1
	bne		a1 t4 end_if
	li 		a0 0
pop(t4)
	ret
end_if:
	li 		a0 0         # ������������� �������� ����������� (-1, ������ ��� �� �������� � 0)
	li 		t6 1          # t2 ����� �������������� ��� �������� ������� ����
loop:
    addi	a0 a0 1       # ����������� ������� �������
    slli 	t6 t6 1       # �������� ��� � t2 �� ���� ������� �����
    blt		t6 a1 loop     # ���� t2 ��� ��� ������ t0, ���������� ����
pop(t4)
	ret
