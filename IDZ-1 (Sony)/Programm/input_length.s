.include "macrolib.s"
.global input_length

.text
input_length:     	
	li 		t0 10							# Write 10 to register t0
	print_str ("Input array lenght: ")		# Hint for entering length
	read_int (a0)							# Enter length
	blez	a0 error_1						# Checking if the length is greater than 0
	bgt 	a0 t0 error_2					# Checking that the length is less than 10
	ret										# Vozvrat k pregdnemu chislu
error_1:
	# Error message output
    print_str ("Incorrect input! Lenght cannot be less than or equal to 0\n")
    exit									# Completing the program		
error_2:
	# Error message output
    print_str ("Incorrect input! Lenght cannot be more than 10\n")		
    exit									# Completing the program
