.include "macrolib.s"
.global	strcpy

.text
strcpy:
	li	t1 16				# Счетчик размера строки
loop:
	lb	t0 (a0)				# Чтение байта по адресу a0 
	sb	t0 (a1)				# Запись байта по адресу a1 
	beqz 	t0 finish		# Усливие выхода из цикла
	addi 	t1 t1 -1		# --t2 
	addi	a0 a0 1			# Смещение на следующий символ
	addi	a1 a1 1			# Смещение на следующий символ
	beqz	t1 error		# Проверка на то что строки меньше 15 символов
	j	loop
finish:
	ret
error:
	print_str ("Incorrect string length!!!")
	li	a0 -1
