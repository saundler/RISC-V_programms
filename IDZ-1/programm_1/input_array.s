.include "macrolib.s"
.global input_array

.text
input_array:
loop:   
	beqz    a1 finish						# Yesli ostalos' menshe
	print_str ("Input element value: ")		# Vyvod stroki s podskazkoy vvoda elementa
	read_int (t2)							# Vvod chisla v regsitr v t2
	sw      t2 (a2)							# Zapis' chisla po adresu v a0
    addi    a2 a2 4							# Uvelichim adres na razmer slova v baytakh
    addi    a1 a1 -1						# Umen'shim kolichestvo ostavshikhsya elementov na 1
    j	loop								# Yesli ostalos' bol'she 0
finish:
	ret										# Vozvrat k iskhodnoy programme
