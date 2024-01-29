 .macro	n_input_macro (%x)
	push (t0)
	jal n_input
	la 	t0 %x									# Адрес n в t2
	sw	a0 (t0)									# Загрузка n в память на хранение
	pop (t0)
.end_macro

 .macro	input_array_macro(%x, %y)
 	sep
 	push (t0)
 	push (t1)									# Вывод строки разделителя
	la  t0 %x									# Указатель элемента массива
	lw	t1 %y
	jal input_array
	pop (t1)
	pop (t0)
.end_macro

.macro	output_array_macro (%x, %y)
	sep											# Вывод строки разделителя
	push (t0)
 	push (t1)
	la  t0 %x									# Указатель элемента массива
	lw	t1 %y
	jal output_array
	pop (t1)
	pop (t0)
.end_macro

.macro	sum_array_macro (%x, %y)
	push (t0)
 	push (t1)
	la  t0 %x									# Указатель элемента массива
	lw	t1 %y
	jal sum_array
	print_str ("Sum of array elements: ")		# Вывод строки с подсказкой суммы элементов
    print_int (a0)								# Вывод суммы элементов
    newline										# Переход на следующую строку
    print_str ("Number of summed elements: ")	# Вывод строки с подсказкой количества просуммированных элементов
	lw		t2, %y								# Число элементов массива 
	sub 	t2, t2, t1							# Вычисление количества просуммированных элементов
    print_int (t2)	 	   						# Вывод количества просуммированных элементов
    pop (t1)
	pop (t0)
.end_macro