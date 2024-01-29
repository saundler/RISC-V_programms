.include "macrolib.s"
.global input_array

.text
input_array:
	push (t2)
loop:   
	print_str ("Input element value: ")		# Вывод строки с подсказкой ввода элемента
	read_int (t2)							# Ввод числа в регситр в t2
	sw      t2 (t0)							# Запись числа по адресу в t0
    addi    t0 t0 4							# Увеличим адрес на размер слова в байтах
    addi    t1 t1 -1						# Уменьшим количество оставшихся элементов на 1
    bnez    t1 loop							# Если осталось больше 0
finish:
    pop (t2)
	ret										# Возврат к исходной программе
	
