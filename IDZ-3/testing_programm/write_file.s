.include "macrolib.s"
.include "macroproglib.s"
.global write_file 

# Arguments:
# a0 - file_name: Name of the file to write to
# a1 - result_string
# a2 - string_length

.text
write_file:
    # Save context on the stack
    push(ra)             # Save return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1
    push(s2)             # Save register s2
    
    # Setup string addres and length
	mv	s0 a0
	mv  s1 a1
	mv  s2 a2
	
    # Open file for writing
    open(s0, WRITE_ONLY)
    li   t0, -1          # Check for valid file opening
    beq  a0, t0, er_name # Handle file opening error
    mv   s0, a0          # Save file descriptor
    
    # Write final concatenated string to file
    li   a7, 64          # System call for file write
    mv   a0, s0          # File descriptor
    mv   a1, s1  		# Address of text buffer
   	mv   a2, s2
    ecall                # Write to file

	# Open file for writing
	close(s0)
    # Restore context from the stack
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret

# Error handling for incorrect file name
er_name:
    print_str ("Incorrect file name!!!")
    exit  
