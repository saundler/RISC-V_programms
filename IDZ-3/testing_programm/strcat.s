.include "macrolib.s"
.global strcat


# Arguments:
# a0 - Address of the first string 
# a1 - Address of the second string 

.text
strcat:
    push(ra)             # Save the return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1

    mv    s0, a0         # Move the address of the first string into s0
    mv    s1, a1         # Move the address of the second string into s1

    # Find the end of the first string
find_end_of_a0:
    lb    t1, (s0)       # Load a byte from the address in s0
    beqz  t1, copy_a1    # If it's the null terminator, start copying a1
    addi  s0, s0, 1      # Increment s0 to point to the next byte
    j     find_end_of_a0 # Jump back to continue finding the end

    # Copy the second string to the end of the first string
copy_a1:
    lb    t1, (s1)       # Load a byte from the address in s1
    beqz  t1, done       # If it's the null terminator, finish copying
    sb    t1, (s0)       # Store the byte from s1 into the end of s0
    addi  s0, s0, 1      # Increment s0 to move to the next byte
    addi  s1, s1, 1      # Increment s1 to move to the next byte
    j     copy_a1        # Jump back to continue copying

done:
    sb    zero, (s0)     # Add a null terminator at the end of the concatenated string
    pop(s1)              # Restore s1 from the stack
    pop(s0)              # Restore s0 from the stack
    pop(ra)              # Restore the return address from the stack
    ret                  # Return from the function
