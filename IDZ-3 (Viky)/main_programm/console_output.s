.include "macro-syscalls.m"
.global console_output 

.text
console_output:
	mv	t5 a0				# Move a0 data in t5
	# Print string
    print_str("To output the answer, press Y or N if you don't want: ")
    li t1 78           		# Set 78 value in t1
    li t2 110          		# Set 110 value in t2
    li t3 89           		# Set 89 value in t3
    li t4 121          		# Set 121 value in t4
while:
    li a7 12           		# System call for reading a character
    ecall
    mv t0 a0           		# Move read character to t0
if_n:
    beq t0 t1 continue   	# Check for 'N'
    beq t0 t2 continue   	# Check for 'n'    
if_y:
    beq t0 t3 end_while   	# Check for 'Y'
    beq t0 t4 end_while   	# Check for 'y'
    # Print string
    print_str("\nnon-existent command, re-enter: ")
    j while
end_while:
    newline
    li a7  4           	 	# System call for console output string
    mv a0 t5     			# Address to string buffer
    ecall               	
continue:
    ret                  	# Return from the function
