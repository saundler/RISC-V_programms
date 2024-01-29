# =================================================================================
# Macro library for system calls
# =================================================================================

# ----------------------------------------------------------------------------------
# Print the contents of a given register as an integer
# %x - Register containing the integer to print
.macro print_int (%x)
    li a7, 1          # Set system call number for printing integer
    mv a0, %x         # Move integer from register %x to a0
    ecall             # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Print an immediate integer value
# %x - Immediate integer value to print
.macro print_imm_int (%x)
    li a7, 1          # Set system call number for printing integer
    li a0, %x         # Load immediate integer value into a0
    ecall             # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Print a null-terminated string constant
# %x - String constant to print
.macro print_str (%x)
    .data
    str: .asciz %x    # Define string constant in data section
    .text
    push (a0)         # Save a0 on stack
    li a7, 4          # Set system call number for printing string
    la a0, str        # Load address of string into a0
    ecall             # Execute system call
    pop (a0)          # Restore a0 from stack
.end_macro

# ----------------------------------------------------------------------------------
# Print a single given character
# %x - Character to print
.macro print_char(%x)
    li a7, 11         # Set system call number for printing character
    li a0, %x         # Load character into a0
    ecall             # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Print a newline character
.macro newline
    print_char('\n')  # Print newline character
.end_macro

# ----------------------------------------------------------------------------------
# Read an integer from console into register a0
.macro read_int_a0
    li a7, 5          # Set system call number for reading integer
    ecall             # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Read an integer from console into a specified register, excluding a0
# %x - Target register to store read integer
.macro read_int(%x)
    push (a0)         # Save a0 on stack
    li a7, 5          # Set system call number for reading integer
    ecall             # Execute system call
    mv %x, a0         # Move read integer from a0 to %x
    pop (a0)          # Restore a0 from stack
.end_macro

# ----------------------------------------------------------------------------------
# Read a string into a buffer with a specified size, replacing newline with null
# %strbuf - Address of buffer
.macro str_get(%strbuf)
    push(s3)
    push(s1)
    push(s2)
    li  s3 '\n'         # Set newline character for comparison
    mv  s1  %strbuf     # Set starting address of buffer
next:
    lb  s2  (s1)        # Load byte from buffer
    beq s3  s2  replace  # If newline, replace with null
    addi s1 s1 1        # Increment buffer address
    b   next
replace:
    sb  zero (s1)       # Replace newline with null
    pop(s2)
    pop(s1)
    pop(s3)
.end_macro

# ----------------------------------------------------------------------------------
# Open a file for reading, writing, or appending
.eqv READ_ONLY	0	# Open for reading
.eqv WRITE_ONLY	1	# Open for writting
.eqv APPEND	    9	# Open for appending
# %file_name - Name of the file to open
# %opt       - Option flag (0 for read, 1 for write, 9 for append)
.macro open(%file_name, %opt)
	mv    a0 %file_name # Set file name for opening
    li    a1 %opt       # Set option flag for file opening 
    li    a7 1024       # Set system call number for opening file
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Read information from an opened file
# %file_descriptor - File descriptor of the opened file
# %strbuf          - Address of the buffer for the read text
# %size            - Size of the portion to read
.macro read(%file_descriptor, %strbuf, %size)
    li   a7, 63         # Set system call number for reading from file
    mv   a0, %file_descriptor  # Set file descriptor for reading
    la   a1, %strbuf    # Set buffer address for reading
    li   a2, %size      # Set size of portion to read
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Read information from an opened file, with buffer address in a register
# %file_descriptor - File descriptor of the opened file
# %reg             - Register containing buffer address
# %size            - Size of the portion to read
.macro read_addr_reg(%file_descriptor, %reg, %size)
    li   a7, 63         # Set system call number for reading from file
    mv   a0, %file_descriptor  # Set file descriptor for reading
    mv   a1, %reg       # Set buffer address from register for reading
    mv   a2, %size      # Set size of portion to read
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Close an opened file
# %file_descriptor - File descriptor of the file to close
.macro close(%file_descriptor)
    li   a7, 57         # Set system call number for closing file
    mv   a0, %file_descriptor  # Set file descriptor for closing
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Allocate a dynamic memory area of a specified size
# %size - Size of the memory block to allocate
.macro allocate(%size)
    li a7, 9            # Set system call number for memory allocation
    mv a0, %size        # Set size of memory block to allocate
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Terminate the program
.macro exit
    li a7, 10           # Set system call number for program termination
    ecall               # Execute system call
.end_macro

# ----------------------------------------------------------------------------------
# Save a specified register onto the stack
# %x - Register to save
.macro push(%x)
    addi sp, sp, -4     # Decrement stack pointer
    sw   %x, (sp)       # Save register %x on stack
.end_macro

# ----------------------------------------------------------------------------------
# Pop a value from the top of the stack into a register
# %x - Register to load
.macro pop(%x)
    lw  %x, (sp)        # Load value from stack into register %x
    addi sp, sp, 4      # Increment stack pointer
.end_macro
