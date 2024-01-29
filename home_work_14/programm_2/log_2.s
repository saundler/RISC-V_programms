.include "macro-syscalls.m"

.global log_2

.text
log_2:
push(t4)
if:
	li 		t4 1
	bne		a1 t4 end_if
	li 		a0 0
pop(t4)
	ret
end_if:
	li 		a0 0         # Инициализация счетчика результатов (-1, потому что мы начинаем с 0)
	li 		t6 1          # t2 будет использоваться для проверки каждого бита
loop:
    addi	a0 a0 1       # Увеличиваем счетчик позиции
    slli 	t6 t6 1       # Сдвигаем бит в t2 на одну позицию влево
    blt		t6 a1 loop     # Если t2 все еще меньше t0, продолжаем цикл
pop(t4)
	ret
