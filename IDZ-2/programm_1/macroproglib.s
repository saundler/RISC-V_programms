# Entering the number x and predicting it modulo the number PI
.macro	x_input_macro (%x)
 	push(t0)					# Storing a given int register on the stack
 	# Entering the number x and predicting it modulo the number PI
 	# Returns the number x in register fa0
 	jal x_input
 	la 		t0 %x				# Loads address %x into register t0								
	fsd		fa0 (t0)			# Loads the value fa0 at address t0					
	pop(t0)						# Popping a int value from the top of the stack into a register							
.end_macro

# Calculates -1 to the power of %x
 .macro	power_neg_one_macro (%x)
 	mv		a1 %x				# Load the value %x into register a1
 	# Accepts register a1 (power -1)
 	# Returns -1 to the power of %x in register fa0
 	jal power_neg_one							
.end_macro

# Calculates the number %x to the power of %y
.macro power_macro(%x, %y)
	fmv.d 	fa1 %x 				# Load the value %x into register fa1
	mv		a1 	%y				# Load the value %y into register a1
	# Accepts registers fa1 (a number) a1 (its degree)
	# Returns %x to the power of %y in register fa0
	jal power
.end_macro

# Calculates the factorial of %x
.macro factorial_macro(%x)
	mv		a1 %x				# Load the value %x into register a1
	# Accepts register a1 (number whose factorial needs to be calculated)
	# Returns the value of the factorial in register fa0
	jal factorial
.end_macro

# Calculating sine using Taylor series
.macro sin_taylor_macro(%x, %y, %z)
	push(t0)					# Storing a given int register on the stack
	fld 	fa1 %x t0			# Load register fa1 with the number %x	
	fld 	fa2 %y t0			# Load register fa2 with the number %y
	# Calculating sine using Taylor series
	# Accepts registers fa1 (value of number x) and fa2 (precision of calculations)
	# Returns the value of sin(x) in register fa0 
	jal sin_taylor
	la 		t0 %z				# Loads address %z into register t0								
	fsd		fa0 (t0)			# Loads the value fa0 at address t0	
	pop(t0)						# Popping a int value from the top of the stack into a register
.end_macro

# Calculating cosine using Taylor series
.macro cos_taylor_macro(%x, %y, %z)
	push(t0)					# Storing a given int register on the stack
	fld 	fa1 %x t0			# Load register fa1 with the number %x	
	fld 	fa2 %y t0			# Load register fa2 with the number %y
	# Calculating cosine using Taylor series
	# Accepts registers fa1 (value of number x) and fa2 (precision of calculations)
	# Returns the value of cos(x) in register fa0
	jal cos_taylor
	la 		t0 %z				# Loads address %z into register t0								
	fsd		fa0 (t0)			# Loads the value fa0 at address t0	
	pop(t0)						# Popping a int value from the top of the stack into a register
.end_macro

# Calculating tangent by dividing sine by cosine
.macro tan_macro(%x, %y)
	push(t0)					# Storing a given int register on the stack
	fld 	ft1 %x t0			# Load register ft1 with the number %x	
	fld 	ft2 %y t0			# Load register ft2 with the number %y	
if:
	li			t0 0			# Load 0 into register t0
	fcvt.d.w	ft3 t0			# Load the value t0 into ft3
	feq.d		t0	ft2 ft3		# If ft2 is equal to ft3 write the value 1 to t0 otherwise 0
	beqz 		t0 end_if 		# If t0 is 0, go to the end_if label
	# Line output
	print_str("It is impossible to determine the value of tan(x)")
	j continue					# Go to the continue label
end_if:
	fdiv.d 	ft3 ft1 ft2			# Divide sin(x) by cos(x) and write the resulting value to register ft3 
	sep							# Outputting the delimiter string
	print_str("tan(x) = ")		# Line output					
	print_double(ft3)			# Printing numbers with double type
	newline						# Newline
continue:
	pop(t0)						# Popping a int value from the top of the stack into a register
.end_macro
