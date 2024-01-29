.include "macrolib.s"
.global power_neg_one

.text
power_neg_one:
	push(t0)				# Storing a given int register on the stack
	push(t1)				# Storing a given int register on the stack
    li 		t0 1            # # Load 1 into register t0
    andi 	t1 a1 1      	# t1 = n % 2
    beqz 	t1 even_power 	# If n is even, then the result will be 1.0
    li 		t0 -1           # Otherwise, set the negativity flag to -1
even_power:
    fcvt.d.w fa0 t0    		# Convert the flag to a floating point number
    pop(t1)					# Popping a int value from the top of the stack into a register
	pop(t0)					# Popping a int value from the top of the stack into a register
    ret						# Return to the original program
											
