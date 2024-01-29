.include "macrolib.s"
.global neg_array

.text
neg_array: 
	li		t4 0          					# Zapis v registr a0 chisla 0
loop:  
	beqz    a2 finish						# Yesli ostalos' menshe
	lw		t3 (a1)							# Zapis' elementa massiva v registr t3
	if_negative:
	bgez	t3 end_if						# Esly t3 menshe 0
	sw 		t3 (a3)							# Zapis t3 v rezultiruyshyi massiv
	addi	t4 t4 1							# Uvelychym kolichestvo elementov na 1
	addi 	a3 a3 4							# Uvelichim adres na razmer slova v baytakh
	end_if:
    addi    a1 a1 -4						# Umen'shim adres na razmer slova v baytakh
    addi    a2 a2 -1						# Umen'shim kolichestvo ostavshikhsya elementov na 1
    j loop
finish:
	mv 		a0 t4 							# Peremestim znachenye t4 v registr a0
    ret										# Vozvrat k iskhodnoy programme
    		
