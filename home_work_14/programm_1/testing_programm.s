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
	li 		t1 0xffff0011 		# Адрес на левый индикатор
	j end
even:
	li 		t1 0xffff0010 		# Адрес на правый индикатор
end:
	indicator_output(t4, t1)	# Вывод числа на индикатор
	li 		a7 32
	li 		a0 1000
	ecall
	addi 	t4 t4 1
	bne 	t4 t5 loop
	exit
