.include "macrolib.s"
.global array_fix

.data
.align	2
temp_n: 	.word	0			# Length of temporary array
temp_arr:	.space	40			# Temporary array

.text
array_fix: 
	la 		t2 temp_n 			# Writing the address of the length of the temporary array to register t2
	sw		a2 (t2)          	# Write a2 to address t2
	lw		t4 temp_n			# Writing to t4 the length of the temporary array
	la 		t3 temp_arr			# Writing the address to the first element of the array in t3
	li 		t1 0
while_1:  
	blez    a2 end_while_1		# Loop termination condition
	lw		t0 (a1)				# Writing an array element to t0
	if_first_positive:
	blez	t0 end_if			# Checking that the element is positive		
	bnez 	t1 end_if			# Checking that t1 is not equal to 0
	li		t1 1				# Write 1 to t1
	addi 	t4 t4 -1			# Reducing the length of a temporary array
	sw		t4 (t2)				# Reducing the length of a temporary array
	j continue					# Jump by flag continue
	end_if:
	sw		t0 (t3)				# Writing an element to a temporary array
	addi 	t3 t3 4				# Offset to next cell
	continue:
	addi    a1 a1 4				# Offset to next cell
    addi    a2 a2 -1			# Reduce long unread items
    j while_1
end_while_1:
	la 		a1 temp_arr			# Writing the address to the first element of the array in a1
	lw 		a2 temp_n			# Writing to t4 the length of the temporary array
	li 		t0 4				# Writing the number 4 to t0
	mv 	 	t1 a2				# Copying the value of a2 to t1
	addi 	t1 t1 -1			# Decrease t1 by 1
	mul 	t0 t0 t1			# Multiplying t0 by t1
	add 	a1 a1 t0			# Offset pointer to last element of temporary array
	
while_2:
	blez    a2 end_while_2		# Loop termination condition
	lw		t0 (a1)				# Writing an array element to t0
	sw		t0 (a3)				# Write t0 to address a3
	addi 	a3 a3 4				# Offset to next cell
	addi 	a1 a1 -4			# Offset to next cell
	addi 	a2 a2 -1			# Subtract -1 from the number of elements not read
	j while_2					# Return to the beginning of the cycle
end_while_2:
	lw		a0 temp_n 			# Writing the length of the resulting array to a0
    ret							# Return to original program				
    		
