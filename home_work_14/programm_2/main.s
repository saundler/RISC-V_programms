.include "macro-syscalls.m"
.global main

.text
main:
	lui     s1 0xffff0         
    mv      t5 zero             # счётчик
    li      s2 -1             # предыдущее значение
    li 		s3 20       
# Сканирование клавиатуры  
loop:
    mv      t0 zero            
    li      t1 1             
    sb      t1 0x12(s1)        
    lb      t1 0x14(s1)       
    or      t0 t0 t1           
    li      t1 2               
    sb      t1 0x12(s1)
    lb      t1 0x14(s1)
    or      t0 t0 t1
    li      t1 4               
    sb      t1 0x12(s1)
    lb      t1 0x14(s1)
    or      t0 t0 t1
    li      t1 8                
    sb      t1 0x12(s1)
    lb      t1 0x14(s1)
    or      t0 t0 t1
    li 		a7 32
	li 		a0 250
	ecall
    beq     t0 s2 same
    mv      s2 t0 
    
odd:
	andi 	t1 t5 1
	beqz 	t1 even
	li 		t1 0xffff0011 		# Адрес на левый индикатор
	j end
even:
	li 		t1 0xffff0010 		# Адрес на правый индикатор
end: 
    
# Проверка на наличие нажатий
if:
	bnez	t0	end_if
	li 		t0 -1
	indicator_output(t0, t1)
	addi 	t5 t5 1 
	j same
end_if: 
	
# Преобразование значения в десятичное число
    andi 	t4 t0 0xF
    log_2(t4)
    mv 		t4 a0  
    li 		t3 4
    mul 	t4 t4 t3
    srai 	t3 t0 4   
	andi 	t3 t3 0xF
	log_2(t3)	
    add 	t4 t4 a0
# Вывод числа в консоль
	indicator_output(t4, t1)
	addi 	t5 t5 1 
same:
	ble     t5 s3 loop
	exit
