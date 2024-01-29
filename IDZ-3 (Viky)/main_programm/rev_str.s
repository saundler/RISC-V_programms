.include "macro-syscalls.m"
.global rev_str

.text
rev_str:
    push(s0)             	# Save the s0 register on the stack
    push(s1)             	# Save the s1 register on the stack
    mv    s0 a0         	# Copy the start address of the string into s0
    mv    s1 a0         	# Initialize s1 to find the end of the string
find_end:
    lbu   a0 (s1)       	# Load a byte from the address in s1
    beqz  a0 continue    	# If it's a null terminator, begin reversing
    addi  s1 s1 1      		# Increment s1 to point to the next byte
    j     find_end       	# Loop back to continue finding the string's end
continue:
    addi  s1 s1 -1     		# Decrement s1 to point to the last valid character
while:
    bge   s0 s1 end_while  	# If s0 has passed or reached s1, end the reverse
    lbu   a0 (s0)       	# Load the byte from the address in s0
    lbu   a1 (s1)       	# Load the byte from the address in s1
    sb    a0 (s1)       	# Store the byte from s0 into s1
    sb    a1 (s0)       	# Store the byte from s1 into s0
    addi  s0 s0 1      		# Increment s0 to move to the next byte
    addi  s1 s1 -1     		# Decrement s1 to move to the previous byte
    j while  		 		# Jump back to continue the reverse process
end_while:
    pop(s1)             	# Restore the s1 register from the stack
    pop(s0)              	# Restore the s0 register from the stack
    ret                  	# Return from the function
