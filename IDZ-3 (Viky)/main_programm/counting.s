.include "macro-syscalls.m"
.include "programms-macros.m"
.global counting 

.data
letters_str:        .asciz "Number of letters: "  	# String for the count of letters.
letters_buffer:     .space 12                    	# Buffer for the converted letters count
numbers_str:        .asciz "\nNumber of numbers: " 	# String for the count of numbers
numbers_buffer:  	.space 12                    	# Buffer for the converted numbers count

.text
counting:
	push(ra)
    push(s0)            		# Save register s0
    push(s1)            		# Save register s1
    push(s2)            		# Save register s2
    push(s3)            		# Save register s3
    push(s4)            		# Save register s4
    push(s5)            		# Save register s5
    push(s6)            		# Save register s6
    push(s7)					# Save register s7
    push(s8)					# Save register s8
    push(s9)					# Save register s9
    mv s0 a0           			# Copy the buffer address to s0
    mv s9 a1
    li s1 0            			# Initialize s1 to 0
    li s2 0            			# Initialize s2 to 0
    li s3 65           			# ASCII value for 'A'
    li s4 90           			# ASCII value for 'Z'
    li s5 97           			# ASCII value for 'a'
    li s6 122          			# ASCII value for 'z'
    li s7 48           			# ASCII value for '0'
    li s8 57           			# ASCII value for '9'
	
    # Counting
while:
    lbu t0 (s0)        			# Load byte (character) from the string
    beqz t0 end_while   		# If it's null terminator, end loop
if_big_letter:
    blt t0 s3 if_small_letter 	# If char < 'A', go to check for lowercase
    bgt t0 s4 if_small_letter 	# If char > 'Z', go to check for lowercase
    addi s1 s1 1     			# Add 1 value to s1
    j end_if
if_small_letter:
    blt t0 s5 if_number 		# If char < 'a', go to check for number
    bgt t0 s6 if_number 		# If char > 'z', go to check for number
    addi s1 s1 1       			# Add 1 value to s1
    j end_if
if_number:
    blt t0 s7 end_if    		# If char < '0', go to end_if
    bgt t0 s8 end_if    		# If char > '9', go to end_if
    addi s2 s2 1       
end_if:
    addi s0 s0 1        		# Move to the next character in the string
    j while						# Return to start
    
end_while:

    li   s3, 52								# Initialize s4 for string length calculation 
# Convert letters count to string and concatenate
    cat_str(s9, letters_str)
    ITOS(s1, letters_buffer)    	# Convert letters count to string
    add  s3, a0, s3      					# Update total string length
    cat_str(s9, letters_buffer)     			# Concatenate letters count string
# Convert numbers count to string and concatenate
    cat_str(s9, numbers_str)
    ITOS(s2, numbers_buffer) 		# Convert numbers count to string
    add  s3, a0, s3      					# Update total string length
    cat_str(s9, numbers_buffer)  			# Concatenate numbers letters count string
    mv	a0 s3								# Save length in a0		
    pop(s9)
    pop(s8)						
    pop(s7)
    pop(s6)		
    pop(s5)
    pop(s4)
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret                   		# Return from the function
