.include "macrolib.s"
.global	strcpy

.text
strcpy:
	li	t1 16				# ������� ������� ������
loop:
	lb	t0 (a0)				# ������ ����� �� ������ a0 
	sb	t0 (a1)				# ������ ����� �� ������ a1 
	beqz 	t0 finish		# ������� ������ �� �����
	addi 	t1 t1 -1		# --t2 
	addi	a0 a0 1			# �������� �� ��������� ������
	addi	a1 a1 1			# �������� �� ��������� ������
	beqz	t1 error		# �������� �� �� ��� ������ ������ 15 ��������
	j	loop
finish:
	ret
error:
	print_str ("Incorrect string length!!!")
	li	a0 -1
