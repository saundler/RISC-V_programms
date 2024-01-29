.include "macrolib.s"
.include "macroproglib.s"
.global cos_taylor

.text
cos_taylor: 
	push(ra)    					# Storing a given int register on the stack
	push(t0)						# Storing a given int register on the stack
	pushd(ft4)						# Storing a given double register on the stack
	pushd(ft1)						# Storing a given double register on the stack
	li 		t0 0					# Load 0 into t0
loop:
	# Definition of sign	
	power_neg_one_macro(t0)			# -1 to the power t0
	fmv.d 		ft1 fa0				# Load register ft1 with the value of register fa0
	
	# Calculation 2*n
	mv 			t1 t0				# Transfer the value of t0 to t1
	add			t1 t1 t1			# Increase t1 by 2 times
		
	# Numerator calculation
	power_macro(fa1 t1)				# Calculate fa1 to the power of t1
	fmv.d 		ft2 fa0				# Load register ft2 with the value of register fa0
	
	# Calculating the denominator
	factorial_macro(t1)				# Calculate the factorial of t1
	fmv.d		ft3 fa0 			# Load register ft3 with the value of register fa0

	# Calculation of new term
	fmul.d 		ft0 ft1 ft2			# ft0 = ft1 * ft2
	fdiv.d 		ft0 ft0 ft3			# ft0 = ft0 / ft3
	  
	fadd.d		ft4 ft4 ft0			# Calculating a new value
	addi 		t0 t0 1				# Counter increase
	fdiv.d 		ft6 ft0 ft4			# Accuracy calculation

	fabs.d		ft6 ft6				# Load the module from ft6 into ft6
	fle.d 		t2 ft6 fa2			# If ft6 <= fa2 write the number 1 to t2 otherwise 0
    bnez 		t2 finish    		# # If t2 is not equal to 0, go to the finish label
    j	loop	
finish:
	fmv.d		fa0 ft4				# Load register fa0 with the value of register ft4
	popd(ft1)						# Popping a double value from the top of the stack into a register
	popd(ft4)						# Popping a double value from the top of the stack into a register
	pop(t0)							# Popping a int value from the top of the stack into a register
	pop(ra)							# Popping a int value from the top of the stack into a register
	ret								# Return to the original program
