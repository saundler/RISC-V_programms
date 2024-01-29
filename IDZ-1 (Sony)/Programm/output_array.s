.include "macrolib.s"
.global output_array

.text
output_array:
while:
	beqz    a1 end_while			# Loop termination condition
    lw		t0 (a0)					# Writing an element to register t0
    print_int (t0)					# Element output
	print_char (' ')				# Space output
    addi    a0 a0 4					# Offset to next cell
    addi    a1 a1 -1				# Subtract -1 from the number of elements not output
    j 	while
end_while:
	print_char ('\n')				# Line break
    ret								# Return to original program
