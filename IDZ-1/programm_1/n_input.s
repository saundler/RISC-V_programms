.include "macrolib.s"
.global n_input

.text
n_input:     	
	print_str ("Input array lenght n = ")		# Podskazka vvoda dliny massiva
	read_int (a0)								# Vvod dliny massiva
	blez	a0 fail								# Na oshibku, yesli men'she 0
	li 		t0 10								# Zapis' chisla 10 v registr t0
	bgt 	a0 t0 fail							# Na oshibku, yesli bol'she 10
	ret											# Vozvrat k pregdnemu chislu
	
fail:
    print_str ("Incorrect input!!!\n")			# Vyvod stroki uvedomlyayushchey ob oshibke
    exit										# Ostanovka programmy
