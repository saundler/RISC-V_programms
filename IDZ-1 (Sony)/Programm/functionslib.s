 .macro	input_length(%x)
 	# Returns the length value in a0
	jal input_length							# Calling the Array Length Input Subroutine
	la 	t0 %x									# Write address %x to t0
	sw	a0 (t0)									# Writing array length to memory
	print_str("----------\n")					# Outputting the delimiter string
.end_macro

 .macro	input_array(%x, %y)
	la  a1 %x									# Write address %x to a1
	lw	a2 %y									# Writing the value of %y to a2
	# Accepts a pointer to the first element of the array in register a1
	# Receives the length of the array in register a2
	jal input_array								# Calling a subplot for entering array elements
	print_str("----------\n")					# Outputting the delimiter string
.end_macro

.macro	output_array(%x, %y, %z)
	la  a0 %x									# Write address %x to a0
	lw	a1 %y									# Writing the value of %y to a1
	print_str (%z)								# Output string %z
	# Accepts a pointer to the first element of the array in register a0
	# Receives the length of the array in register a1
	jal output_array							# Calling a subplot for displaying array elements
	print_str("----------\n")					# Outputting the delimiter string
.end_macro

.macro	array_fix(%a, %n, %f, %m)
	la  	a1 %a								# Writing address %a to a1
	lw		a2 %n								# Writing the value of %n to a2
	la  	a3 %f								# Writing address %a to a1
	# Accepts a pointer to the first element of the source array in register a1
	# Receives the length of the source array in register a2
	# Accepts a pointer to the first element of the result array in register a3
	jal 	array_fix							# Calling a subroutine that forms the resulting array
	la 		t0  %m								# Recording the address %m in the t0
	sw 		a0 (t0)								# Writing a number to an address in t0
.end_macro


