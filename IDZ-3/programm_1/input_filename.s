.include "macrolib.s"
.global input_filename 

# input_filename: Reads a file name from user input.
# Arguments:
# a1 - file_name: The name of the file to be read
# a2 - NAME_SIZE: The maximum size of the file name
# a3 - message

.text
input_filename:
    # Begin the input_filename function.

    # Saving context on the stack
    push(ra)             # Save the return address to the stack.
    push(s1)             # Save register s1 (temporary storage).
    push(s2)             # Save register s2 (temporary storage).
    push(s3)             # Save register s3 (temporary storage).

    # Setup file name and sizes
    mv   s1, a1          # Move file name address to s1.
    mv   s2, a2          # Move name size to s2.
    mv   s3, a3          # Move message address to s3.

    # Prompt user to input file name
    mv 	a0, s3          # Set a0 to the address of the message string.
    mv 	a1, s1          # Set a1 to the address of the file name buffer.
    li 	a2, 256        # Set a2 to the maximum length for input (256 bytes).

    # System call to display the message
    li 	a7, 54          # Set a7 to system call number for sethostname (as an example).
    ecall                # Make the system call.

    str_get(s1)          # Read file name from console into buffer at s1.
    
    # Restoring context from the stack
    pop(s3)              # Restore register s3.
    pop(s2)              # Restore register s2.
    pop(s1)              # Restore register s1.
    pop(ra)              # Restore the return address.
    
    ret                  # Return from the function.
