.include "macro-syscalls.m"
.global write 

.text
write:
    push(s0)            		# Save register s0
    push(s1)             		# Save register s1
    push(s2)            		# Save register s2
    push(s3)              		# Save register s3
    mv s0 a0            		# Move file to s0
    mv s1 a1            		# Move answer to s1
    mv s2 a2            		# Move answer length to s2
    open(s0, WRITE_ONLY)
    li   t0, -1          # Check for valid file opening
    beq  a0, t0, er_name # Handle file opening error
    mv   s0, a0          # Save file descriptor
    li a7 64           			# System call for file write
    mv a0 s0           			# File descriptor
    mv a1 s1     		# Address of text buffer
    mv a2 s2					# Set 20 value in a2
    ecall               		# Write to file
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    ret

# Error handling for incorrect file name
er_name:
	# Print string
    print_str("Incorrect file name!!!")
    exit  
