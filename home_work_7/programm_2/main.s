.include "macrolib.s"
.include "macroproglib.s"

.data
.align	2
n: 		.word	0								# Число элементов в массиве
arr:	.space	40								# Выделение памяти для массива

.text
main:
	n_input_macro (n)							
	input_array_macro (arr, n)					# Вызов подпрограммы ввода массива
    output_array_macro (arr, n)					# Вызов подпрограммы вывода массива
    sum_array_macro	(arr, n)					# Вызов подпрограммы вычисляющей сумму массива
    exit										# Остановка программы					
