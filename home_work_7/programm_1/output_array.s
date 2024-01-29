.include "macrolib.s"
.global output_array

.text
output_array:
	print_str ("Array: ")			# Вывод строки с подсказкой содержания массива
loop:
    lw		t2 (t0)					# Запись элемента массива в регистр a2
    print_int (t2)					# Вывод элемента массива
	print_char (' ')				# Вывод пробела
    addi    t0 t0 4					# Увеличим адрес на размер слова в байтах	
    addi    t1 t1 -1				# Уменьшим количество оставшихся элементов на 1
    bnez    t1 loop					# Если осталось больше 0
finish:
	newline							# Переход на следующую строку
    ret								# Возврат к исходной программе
