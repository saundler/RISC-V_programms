 .macro	n_input_macro (%x)
 	# Nichego ne prinimaet
	# Vosvrashyaet chislo n(dlinu massiva)
	jal n_input									# Vyzov podporgammy vvoda chysla n
	la 	t0 %x									# Zapis adresa %x v t0
	sw	a0 (t0)									# Zagruzka n v pamyat' na khraneniye
	sep											# Vyvod stroki razdelitelya
.end_macro

 .macro	input_array_macro(%x, %y)
	la  a2 %x									# Zapis adresa %x v a2
	lw	a1 %y									# Zapys znachenya %y v a1
	# Factychecskie parametry: a2 - adress massiva, a1 - kolichestvo elementov v amssive
	# Nichego ne vosvrashyaet
	jal input_array								# Vyzov podporgammy vvoda elementov massiva
	sep											# Vyvod stroki razdelitelya
.end_macro

.macro	output_array_macro (%x, %y)
	la  a2 %x									# Zapis adresa %x v a2
	lw	a1 %y									# Zapys znachenya %y v a1
	# Factychecskie parametry: a2 - adress massiva, a1 - kolichestvo elementov v amssive
	# Nichego ne vosvrashyaet
	jal output_array							# Vyzov podporgammy vyvoda elementov massiva
	sep											# Vyvod stroki razdelitelya
.end_macro

.macro	neg_array_macro (%a, %n, %f, %m)
	la  	a1 %a								# Zapis adresa %a v t0
	lw		a2 %n								# Zapys znachenya %n v t1
	la  	a3 %f								# Zapis adresa %f v t2
	li 		t3 4								# Zapis v registr t3 chisla 4 
	mv 	 	t6 a2								# Peremestim znachenye t6 v registr t3
	addi 	t6 t6 -1							# Vychtem 1
	mul 	t3 t3 t6							# Umnozhenye registra t3 na registr t6
	add 	a1 a1 t3							# Pibavlenye k registru t0 registra t3
	# Factychecskie parametry: a1 - adress izhod massiva, a2 - kolichestvo elementov v amssive, a1 - adress rezul massiva
	# Vosvrashyaet kolichestvo elementov v result massive
	jal 	neg_array							# Vyzov podporgammy  poiska i zapis otricatelnyh elementov
	la 		t3  %m								# Zapis adresa %m v t3
	sw 		a0 (t3)								# Zapis chisla po adresu v t3
.end_macro


