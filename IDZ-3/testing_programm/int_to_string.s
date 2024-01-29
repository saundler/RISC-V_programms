.include "macrolib.s"
.include "macroproglib.s"

.global int_to_string

.data
digits: 	.asciz "0123456789"  # Define a string of digits for ASCII conversion

# Arguments:
# a0 - Number to convert
# a1 - Address of buffer to save the string

.text
int_to_string:
    push(ra)             # Save the return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1
    push(s2)             # Save register s2

    mv	s0, a0            # Move the number to be converted into s0
    mv	s1, a1            # Move the buffer address into s1
    li 	s2, 0             # Initialize s2 to 0 (counter for the number of digits)
    
    beqz   s0, convert_zero  # If the number is zero, handle it separately

    # Initialization
    la    t2, digits     # Load address of the digits string
    mv    t3, s1         # Save the start address of the buffer in t3

convert_loop:
    # Divide the number by 10
    li    t1, 10
    rem   t4, s0, t1     # Get the remainder (t4 = s0 % 10)
    div   s0, s0, t1     # Divide the number by 10 (s0 = s0 / 10)

    # Get the corresponding ASCII character
    add   t4, t4, t2
    lb    t4, (t4)       # Load ASCII character of the digit
    sb    t4, (s1)       # Save the character in the buffer
    addi  s1, s1, 1      # Move to the next position in the buffer
    addi  s2, s2, 1      # Increment the digit count
    bnez  s0, convert_loop  # If s0 is not zero, continue loop

    # Add null terminator to the string
    sb    zero, (s1)

    # Reverse the string
    str_reverse(t3)      # Call function to reverse the string
    mv    a0, s2         # Move the digit count to a0
    pop(s2)              # Restore s2 from the stack
    pop(s1)              # Restore s1 from the stack
    pop(s0)              # Restore s0 from the stack
    pop(ra)              # Restore the return address from the stack
    ret					 # Return from the function

convert_zero:
    # Handle the case when the number is zero
    li    t0, 48         # ASCII value for '0'
    
    sb    t0, (s1)       # Store '0' in the buffer
    addi  s1, s1, 1      # Increment buffer pointer
    sb    zero, (s1)     # Add null terminator
    li    a0, 1          # Set the digit count to 1
    pop(s2)              # Restore s2 from the stack
    pop(s1)              # Restore s1 from the stack
    pop(s0)              # Restore s0 from the stack
    pop(ra)              # Restore the return address from the stack
    ret					 # Return from the function
