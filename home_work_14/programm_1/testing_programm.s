.include "macro-syscalls.m"
.global main

.text
main:
	li 		t4 0
	li 		t5 30
loop:
odd:
	andi 	t2 t4 1
	beqz 	t2	even
	li 		t1 0xffff0011 		# ����� �� ����� ���������
	j end
even:
	li 		t1 0xffff0010 		# ����� �� ������ ���������
end:
	indicator_output(t4, t1)	# ����� ����� �� ���������
	li 		a7 32
	li 		a0 1000
	ecall
	addi 	t4 t4 1
	bne 	t4 t5 loop
	exit
