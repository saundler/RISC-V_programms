.include "macro-syscalls.m"
.global input_path 

.text
input_path:
    push(ra)             # Save the return address to the stack.
    push(s1)             # Save register s1 (temporary storage).
    push(s2)             # Save register s2 (temporary storage).
    push(s3)             # Save register s3 (temporary storage).
    mv   s1, a1          # Move file name address to s1.
    mv   s2, a2          # Move name size to s2.
    mv   s3, a3          # Move message address to s3.
    mv 	a0, s3           # Set a0 to the address of the message string.
    mv 	a1, s1           # Set a1 to the address of the file name buffer.
    li 	a2, 256          # Set a2 to the maximum length for input (256 bytes).
    li 	a7, 54           # Set a7 to system call number for sethostname (as an example).
    ecall                # Make the system call.
    str_get(s1)          # Read file name from console into buffer at s1.
    pop(s3)              # Restore register s3.
    pop(s2)              # Restore register s2.
    pop(s1)              # Restore register s1.
    pop(ra)              # Restore the return address.
    
    ret                  # Return from the function.
