.include "macro-syscalls.m"

.global indicator_output

.text
indicator_output: 
	mv		t3 a0
	andi	t0 t3 0xF	# Взятие модуля по числу F
	
# Присваивание значения для вывода в индикатор
case_0:
	li 		t1 0
	bne		t1 t0 case_1
	li    	t0 0x3F
	j end
case_1:
	li 		t1 1
	bne		t1 t0 case_2
	li    	t0 0x06
	j end
case_2:
	li 		t1 2
	bne		t1 t0 case_3
	li 		t0 0x5B
	j end
case_3:
	li 		t1 3
	bne		t1 t0 case_4
	li    	t0 0x4F
	j end
case_4:
	li 		t1 4
	bne		t1 t0 case_5
	li    	t0 0x66
	j end
case_5:
	li 		t1 5
	bne		t1 t0 case_6
	li 		t0 0x6D
	j end
case_6:
	li 		t1 6
	bne		t1 t0 case_7
	li 		t0 0x7D
	j end
case_7:
	li 		t1 7
	bne		t1 t0 case_8
	li 		t0 0x07
	j end
case_8:
	li 		t1 8
	bne		t1 t0 case_9
	li 		t0 0x7F
	j end
case_9:
	li 		t1 9
	bne		t1 t0 case_a
	li 		t0 0x6F
	j end
case_a:
	li 		t1 10
	bne		t1 t0 case_b
	li 		t0 0x77
	j end
case_b:
	li 		t1 11
	bne		t1 t0 case_c
	li 		t0 0x7C
	j end
case_c:
	li 		t1 12
	bne		t1 t0 case_d
	li 		t0 0x39
	j end
case_d:
	li 		t1 13
	bne		t1 t0 case_e
	li 		t0 0x5E
	j end
case_e:
	li 		t1 14
	bne		t1 t0 case_f
	li 		t0 0x79
	j end
case_f:
	li 		t1 15
	bne		t1 t0 end
	li 		t0 0x71
end:

# Прибавление точки в случае если число больше F
if_a0_greater_15:
	beq 	t3 t1 end_if
	li 		t1 0x80     # Шестнадцатеричное представление точки
    or 		t0 t0 t1
end_if:

# Вывод
    sb  	t0 (a1)
    ret
