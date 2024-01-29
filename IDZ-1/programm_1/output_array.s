.include "macrolib.s"
.global output_array

.text
output_array:
	print_str ("Array: ")			# Vyvod stroki s podskazkoy soderzhaniya massiva
loop:
	beqz    a1 finish				# Yesli ostalos' menshe
    lw		t2 (a2)					# Zapis' elementa massiva v registr t2
    print_int (t2)					# Vyvod elementa massiva
	print_char (' ')				# Vyvod probela
    addi    a2 a2 4					# Uvelichim adres na razmer slova v baytakh
    addi    a1 a1 -1				# Umen'shim kolichestvo ostavshikhsya elementov na 1
    j 	loop
finish:
	newline							# Perekhod na sleduyushchuyu stroku
    ret								# Vozvrat k iskhodnoy programme
