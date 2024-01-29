.include "macrolib.s"
.global read_file 

# Arguments:
# a1 - file_name: The name of the file to be read
# a2 - TEXT_SIZE: The maximum size of the text to be read

.text
read_file:
    # Saving context on the stack
    push(ra)             # Save the return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1
    push(s2)             # Save register s2
    push(s4)
    # Setup file name and sizes
    mv   s1 a1          # Move file name to s1
    mv   s2 a2          # Move text size to s2
    
    # Open file for reading
    open(s1, READ_ONLY)
    li   t0, -1          # Check for valid file opening
    beq  a0, t0, er_name # Handle file opening error

    # Allocate initial memory block for buffer on the heap
    mv   s0, a0          # Save file descriptor
    allocate(s2)         # Allocate memory block of size s2
    mv   s3, a0          # Save heap address to s3
    mv   t1, a0          # Save modifiable heap address to t1
    mv   s4, zero        # Initialize length of read text to 0
	
read_loop:
    # Read information from the opened file
    read_addr_reg(s0, t1, s2) # Read into block address from register

    # Check for successful read
    beq  a0, t0, er_read # If read error, go to error handling
    add  s4, s4, a0      # Increase text size by the read portion

    # If the length of the read text is less than the buffer size, finish process
    bne  a0, s2, end_loop
   
    # Otherwise, extend buffer and repeat
    allocate(s2)         # Allocate more memory
    add  t1, t1, s2      # Move read address forward by portion size
    b    read_loop       # Continue reading next portion of text

end_loop:
    # Close the file
    close(s0)

    # Set null at the end of the read string
    add  t0 s3 s4      # Address of the last read character
    addi t0 t0 1       # Position for null terminator
    sb   zero (t0)      # Write null terminator at the end of the text

    # Prepare return values
    mv   a0 s0          # File descriptor
    mv   a1 s3          # Start of buffer

    # Restore context from the stack
    pop(s4)
    pop(s3)
    pop(s1)
    pop(s0)
    pop(ra)
    ret

# Error handling for incorrect file name
er_name:
    print_str ("Incorrect file name!!!")
    exit

# Error handling for read operation
er_read:
    print_str ("Incorrect read operation!!!")
    exit
