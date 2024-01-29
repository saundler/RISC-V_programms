.include "macrolib.s"
.global str_reverse

.text
str_reverse:
    push(ra)             # Save the return address on the stack
    push(s0)             # Save the register s0 on the stack
    push(s1)             # Save the register s1 on the stack

    mv    s0, a0         # Move the start address of the string into s0
    mv    s1, a0         # Use s1 to find the end of the string

    # Find the end of the string
find_end:
    lbu   a0, (s1)       # Load a byte from the address in s1
    beqz  a0, reverse    # If it's the null terminator, start reversing
    addi  s1, s1, 1      # Increment the s1 to point to the next byte
    j     find_end       # Jump back to continue finding the end

reverse:
    addi  s1, s1, -1     # Decrement s1 to point to the last valid character

    # Loop to reverse the string
reverse_loop:
    bge   s0, s1, done_reverse  # If s0 has passed or reached s1, we're done reversing
    lbu   a0, (s0)       # Load the byte from the address in s0
    lbu   a1, (s1)       # Load the byte from the address in s1
    sb    a0, (s1)       # Store the byte originally at s0 into s1
    sb    a1, (s0)       # Store the byte originally at s1 into s0
    addi  s0, s0, 1      # Increment s0 to move to the next byte
    addi  s1, s1, -1     # Decrement s1 to move to the previous byte
    j     reverse_loop   # Jump back to continue reversing

    # Finished reversing
done_reverse:
    pop(s1)              # Restore the register s1 from the stack
    pop(s0)              # Restore the register s0 from the stack
    pop(ra)              # Restore the return address from the stack
    ret                  # Return from the function
