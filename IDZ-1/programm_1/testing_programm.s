.include "macrolib.s"
.include "macroproglib.s"

.data
.align	2
n1: 	.word	1								# Chislo elemntov v izhodnom massive
n2:		.word	1								# Chislo elemntov v izhodnom massive
n3:		.word	1								# Chislo elemntov v izhodnom massive
n4:		.word	5								# Chislo elemntov v izhodnom massive
n5:		.word	9								# Chislo elemntov v izhodnom massive
arr1:											# Pervyi massiv
		.word 	1
arr2:   										# Vtoroi massiv
		.word  -5
arr3:   										# Tretiy massiv
		.word  0
arr4:   										# Chetvertyi massiv
		.word  1
		.word  -2147483648
		.word  2147483647
		.word  0
		.word  5
arr5:   										# Piatyi massiv
		.word  10
		.word  -250
		.word  150
		.word  0
		.word  -5	
		.word  1
		.word  -9
		.word  45
		.word  13
m: 		.word	0								# Chislo elemntov v rezultiruyshem massive
finarr:	.space 	40								# Vydelenue pamyati pod rezultiruyshyi massiv	

.text
tests:
	# Vyvid elementov izhodnogo massiva
    output_array_macro (arr1, n1)
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr1, n1, finarr, m)
    print_str("neg_")
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)		
	# Vyvid elementov izhodnogo massiva
    output_array_macro (arr2, n2)
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr2, n2, finarr, m)
    print_str("neg_")
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)	
   	# Vyvid elementov izhodnogo massiva
    output_array_macro (arr3, n3)
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr3, n3, finarr, m)
    print_str("neg_")
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)	
    # Vyvid elementov izhodnogo massiva
    output_array_macro (arr4, n4)
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr4, n4, finarr, m) 
    print_str("neg_")
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)	
    # Vyvid elementov izhodnogo massiva
    output_array_macro (arr5, n5)
    # Poisk i zapis otricatelnyh elementov izhodnogo massiva v rezultiruyshyi
    neg_array_macro	(arr5, n5, finarr, m)
    print_str("neg_")
    # Vyvod elementov rezultiruyshigo massiva
    output_array_macro (finarr, m)				
    exit
