.include "macrolib.s"
.global letter_counting 


# Arguments:
# a0 - buffer: Pointer to the string to be analyzed

.text
letter_counting:
    # Saving context on the stack
    push(ra)             # Save the return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1
    push(s2)             # Save register s2
    push(s3)             # Save register s3
    push(s4)             # Save register s4
    push(s5)             # Save register s5
    push(s6)             # Save register s6

    # Setting up registers
    mv    s0, a0         # Copy the buffer address to s0
    li    s1, 0          # Initialize s1 (count of capital letters) to 0
    li    s2, 0          # Initialize s2 (count of lowercase letters) to 0
    li    s3, 65         # ASCII value for 'A'
    li    s4, 90         # ASCII value for 'Z'
    li    s5, 97         # ASCII value for 'a'
    li    s6, 122        # ASCII value for 'z'

    # Loop to iterate through the string
loop:
    lbu   t0, (s0)       # Load byte (character) from the string
    beqz  t0, end_loop   # If it's null terminator, end loop

    # Check if the character is capital
if_capital:
    blt   t0, s3, end_if # If char < 'A', go to end_if
    bgt   t0, s4, if_line # If char > 'Z', go to check for lowercase
    addi  s1, s1, 1      # Increment capital letters count
    j     end_if

    # Check if the character is lowercase
if_line:
    blt   t0, s5, end_if # If char < 'a', go to end_if
    bgt   t0, s6, end_if # If char > 'z', go to end_if
    addi  s2, s2, 1      # Increment lowercase letters count

    # Increment string pointer and repeat
end_if:
    addi  s0, s0, 1      # Move to the next character in the string
    j     loop

    # Finalization and restoring context
end_loop:
    mv    a0, s1         # Move capital letters count to a0
    mv    a1, s2         # Move lowercase letters count to a1

    # Restore all the registers from the stack
    pop(s6)
    pop(s5)
    pop(s4)
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret                  # Return from the function
