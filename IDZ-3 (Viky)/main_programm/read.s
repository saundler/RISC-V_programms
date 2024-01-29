.include "macro-syscalls.m"
.global read 

.text
read:
    push(ra)             		# Save the return address
    push(s0)             		# Save register s0
    push(s1)             		# Save register s1
    push(s2)             		# Save register s2
    push(s4)			 		# Save register s4
    mv   s1 a1          		# Move file name to s1
    mv   s2 a2          		# Move text size to s2
    open(s1, READ_ONLY)
    li   t0, -1          		# Check for valid file opening
    beq  a0, t0, er_name 		# Handle file opening error
    mv   s0, a0          		# Save file descriptor
    allocate(s2)         		# Allocate memory block of size s2
    mv   s3, a0          		# Save heap address to s3
    mv   t1, a0          		# Save modifiable heap address to t1
    mv   s4, zero        		# Initialize length of read text to 0

while:
    read_addr_reg(s0, t1, s2) 	# Read into block address from register
    beq  a0, t0, er_read 		# If read error, go to error handling
    add  s4, s4, a0      		# Increase text size by the read portion
    bne  a0, s2, end_while 		# If the length of the read text is less than the buffer size, finish process
    allocate(s2)         		# Allocate more memory
    add  t1, t1, s2      		# Move read address forward by portion size
    j    while       			# Continue reading next portion of text
end_while:
    close(s0)					# Close the file
    add  t0 s3 s4      			# Address of the last read character
    addi t0 t0 1       			# Position for null terminator
    sb   zero (t0)      		# Write null terminator at the end of the text
    mv   a0 s0          		# File descriptor
    mv   a1 s3          		# Start of buffer
    pop(s4)
    pop(s3)
    pop(s1)
    pop(s0)
    pop(ra)
    ret

er_name:
	# Print string
    print_str ("Incorrect file name!!!")
    exit

er_read:
	# Print string
    print_str ("Incorrect read operation!!!")
    exit
