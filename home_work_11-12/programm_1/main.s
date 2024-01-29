.include "macrolib.s"

.eqv 	SIZE 16
.data
test_str1:	.asciz ""
test_str2:	.asciz "Hello world!\n"
test_str3:	.asciz "Bye world!\n"
input:		.space SIZE
result:		.space SIZE

.global main

.text
main:
test_1:
	# Коппирование строки
	strcpy (result, test_str1)
	# Вывод  строки
	print_lstr (result)
test_2:	
	# Коппирование строки
	strcpy (result, test_str2)
	# Вывод  строки
	print_lstr (result)
test_3:	
	# Коппирование строки
	strcpy (result, test_str3)
	# Вывод  строки
	print_lstr (result)
test_4:	
	# Вывод  строки
	print_str ("Input the string with length <= 15:\n")
	
	li	a7 8						# 8 системный вызов - чтение строки
	la	a0 input					# Указание адреса для чтения строки
	li	a1 SIZE						# Допустимый размер строки
	ecall
	
	print_str ("\nResult:\n")
	# Коппирование строки
	strcpy (result, input)	
	# Вывод  строки
	print_lstr (result)
	
	# Завершение программы
	exit
