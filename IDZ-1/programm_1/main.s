.include "macrolib.s"
.include "macroproglib.s"

.data
.align	2
n: 		.word	0								# Chislo elemntov v izhodnom massive
arr:	.space	40								# Vydelenue pamyati pod izhodnyi massiv
m: 		.word	0								# Chislo elemntov v rezultiruyshem massive
finarr:	.space 	40								# Vydelenue pamyati pod rezultiruyshyi massiv

.text
main:
	# Vvod kolichestva elementov v izhodnom massive
	n_input_macro (n)
	# Vvod elementov izhodnogo massiva							
	input_array_macro (arr, n)
	# Vyvid elementov izhodnogo massiva
    output_array_macro (arr, n)	
    print_str("neg_")
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr, n, finarr, m)
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)					
    exit										# Ostanovka programmy			
