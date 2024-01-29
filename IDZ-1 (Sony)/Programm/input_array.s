.include "macrolib.s"
.global input_array

.text
input_array:
while:   
	beqz    a2 end_while					# Loop termination condition
	print_str ("Input element value: ")		# Element input hint
	read_int (t0)							# Entering an element
	sw      t0 (a1)							# Writing a number to an array
    addi    a1 a1 4							# Offset to next cell
    addi    a2 a2 -1						# Subtract -1 from the number of elements not entered
    j	while								# Return to the beginning of the cycle
end_while:
	ret										# Return to original program
