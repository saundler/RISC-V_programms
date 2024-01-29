.include "macrolib.s"
.global n_input

.text
n_input:     
	push (t0)
	print_str ("Input array lenght n = ")		# Подсказка ввода длинны массива
	read_int (a0)								# Ввод длинны массива
	blez	a0 fail								# На ошибку, если меньше 0
	li 		t0 10								# Запись числа 10 в регистр t2
	bgt 	a0 t0 fail							# На ошибку, если больше 10
	pop (t0)
	ret
	
fail:
    print_str ("Incorrect input!!!\n")			# Вывод строки уведомляющей об ошибке
    exit										# Остановка программы
