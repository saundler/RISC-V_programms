.data
    arg01:  .asciz "Input dividend: "
    arg02:  .asciz "Input the divisor: "
    result01: .asciz "Result = "
    result02: .asciz "Remainder = "
    ln:     .asciz "\n"
    wronginput: .asciz "ERROR!!! divisor cannot be 0"
.text
	la 	a0, arg01   # Подсказка для ввода первого числа
    	li 	a7, 4       # Системный вызов №4
        ecall
        li      a7 5        # Системный вызов №5 — ввести десятичное число
        ecall               # Результат — в регистре a0
        mv      t0 a0       # Сохраняем результат в t0

        la 	a0, arg02   # Подсказка для ввода второго числа
        li 	a7, 4       # Системный вызов №4
        ecall
        li      a7 5        # Системный вызов №5 — ввести десятичное число
        ecall               # Результат — в регистре a0
        mv      t1 a0       # Сохраняем результат в t1
        
        if_0:					# Проверка деления на ноль
  	   bnez		t1, if_ddgz_and_dvgz	
  	   la 		a0, wronginput     	# Подсказка для выводимого результата
           li		a7, 4               	# Системный вызов №4
           ecall
 	   li   	a7 10              	# Системный вызов №10 — останов программы
           ecall
           
	if_ddgz_and_dvgz:			# Условие если делитель и делимое положительные
 	   bltz 	t0, if_ddlz_and_dvlz
 	   bltz	t1, if_ddlz_and_dvlz
  	   while1:
   	      bgt	t1, t0, end_while1	
   	      sub	t0, t0, t1		# Вычитание из делимого делителя
   	      addi	t2, t2, 1		# Прибавление к результату единицы
   	      j    while1
	   end_while1: 
  	   j    end_if 
	if_ddlz_and_dvlz:			# Условие если делитель и делимое отрицательные
  	   bgtz	t0, if_ddgz_and_dvlz 
  	   bgtz 	t1, if_ddgz_and_dvlz  
   	   while2:
   	      bgt	t0, t1, end_while2
   	      sub	t0, t0, t1		# Вычитание из делимого делителя
   	      addi	t2, t2, 1		# Прибавление к результату единицы
   	      j    while2	
	   end_while2:
   	   j    end_if
   	if_ddgz_and_dvlz:			# Условие если делитель отрицательный, а делимое положительное
  	   bgtz 		t1, else
  	   addi 		a1, a1, -1	# Присваивание регистру а1 значение -1
  	   mul 		t1, t1, a1		# Замена знака у делителя
  	   while3:
   	      bgt   	t1, t0, end_while3
   	      sub    	t0, t0, t1		# Вычитание из делимого делителя
   	      add   	t2, t2, a1		# Вычитание их результата единицы
    	      j    while3
	   end_while3:
   	   j    end_if  
	 else:					# Условие если делитель положительный, а делимое отрицательное
   	   addi 		a1, a1, -1	# Присваивание регистру а1 значение -1
  	   mul 		t0, t0, a1		# Замена знака у делимого
  	   while4:
   	      bgt   	t1, t0, end_while4
   	      sub    	t0, t0, t1		# Вычитание из делимого делителя
   	      add   	t2, t2, a1		# Вычитание их результата единицы
   	      j    while4
	   end_while4:
	   mul 		t0, t0, a1		# Замена знака у остатка
	 end_if:
        
        la 	a0, result01     # Подсказка для выводимого результата
        li 	a7, 4            # Системный вызов №4
        ecall
        mv      a0, t2      
        li      a7 1             # Системный вызов №1 — вывести десятичное число
        ecall

        la 	a0, ln           # Перевод строки
        li	a7, 4            # Системный вызов №4
        ecall
        
        la	a0, result02     # Подсказка для выводимого результата
        li	a7, 4            # Системный вызов №4
        ecall
        mv	a0, t0
        li	a7 1             # Системный вызов №1 — вывести десятичное число
        ecall
        
        la	a0, ln           # Перевод строки
        li	a7, 4            # Системный вызов №4
        ecall

        li      a7 10      	 # Системный вызов №10 — останов программы
        ecall
