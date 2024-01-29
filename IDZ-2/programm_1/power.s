.include "macrolib.s"
.global power

.text
power:     
	pushd(ft0)				# Storing a given double register on the stack
	push(t0)				# Storing a given int register on the stack
	li 		t0 1			# Load 1 into register t0
	fcvt.d.w 	ft0 t0		# Load the value t0 into ft0
loop:   
	blez    a1 finish		# If a1 is less than or equal to 0, go to the finish label		
	fmul.d  ft0 ft0 fa1		# Multiply register ft0 by fa1
    addi    a1 a1 -1		# Subtract 1 from register a1
    j	loop				# Go to the beginning of the loop
finish:
	fmv.d 	fa0 ft0			# Load register fa0 with the value of register ft0
	pop(t0)					# Popping a int value from the top of the stack into a register
	popd(ft0)				# Popping a double value from the top of the stack into a register
	ret						# Return to the original program

											
