.include "macrolib.s"
.global x_input

.data
PI: 		.double	3.141592653589793

.text
x_input:   
	pushd(ft0)							# Storing a given double register on the stack
	pushd(ft1) 							# Storing a given double register on the stack
	push(t1) 							# Storing a given int register on the stack
	print_str ("Input x = ")			# Line output
	read_double(fa0)					# Reading a number with type double
	fld			ft0 PI t0				# Load the ft0 register with the PI value
	fadd.d 		ft0, ft0, ft0			# Increase the value of ft0 by 2 times
	fdiv.d 		ft1 fa0 ft0				# Divide fa0 by ft0 and write the result to ft1
	fcvt.l.d	t1, ft1, rtz			# Load the whole part of the ft1 register into register t1
	fcvt.d.w 	ft1 t1					# Load the whole part of the ft1 register into the ft1 register
	fnmsub.d 	fa0 ft0 ft1 fa0			# Write the value -(ft0 * ft1 - fa0) in the fa0 register
if:
	fld			ft1 PI t0				# Load the ft1 register with the PI value
	fle.d 		a0 fa0 ft1  			# If fa0 <= ft1 write the number 1 to a0 otherwise 0
	bnez 		a0 else_if  			# If a0 is not equal to 0, go to the else_if label
	fsub.d 		fa0 fa0 ft0				# Subtract from fa0, ft0
	j end_if							# Go to the end_if label
else_if:
	fsub.d 		ft1 ft1 ft0				# Subtract from ft1, ft0	
	fle.d 		a0 ft1 fa0 				# If ft1 <= fa0 write the number 1 to a0 otherwise 0
	bnez 		a0 end_if    			# If a0 is not equal to 0, go to the else_if label
	fadd.d 		fa0 fa0 ft0				# Add ft0 to fa0
end_if:
	pop(t1)								# Popping a int value from the top of the stack into a register
	popd(ft1)							# Popping a double value from the top of the stack into a register
	popd(ft0)							# Popping a double value from the top of the stack into a register
	ret									# Return to the original program

											
