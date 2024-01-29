.include "macrolib.s"
.include "macroproglib.s"
.global result_string 

# Arguments:
# a0 - line_cnt: Count of line letters to be written in the file
# a1 - capital_cnt: Count of capital letters to be written in the file

.data
line_str:            .asciz "Number of line letters: "  # String for line letters count
line_cnt_buffer:     .space 12                          # Buffer for converted line count
capital_str:         .asciz "\nNumber of capital letters: " # String for capital letters count
capital_cnt_buffer:  .space 12                          # Buffer for converted capital count
result_str:			 .space 100

.text
result_string:
    # Save context on the stack
    push(ra)             # Save return address
    push(s0)             # Save register s0
    push(s1)             # Save register s1
    push(s2)             # Save register s2

    # Setup file name and sizes
    mv   s0, a0          # Move line count to s0
    mv   s1, a1          # Move capital letters count to s2
    li   s2, 52          # Initialize s4 for string length calculation
    
    # Convert line count to string and concatenate
    strcat(result_str, line_str)
    int_to_string(s0, line_cnt_buffer)    # Convert line count to string
    add  s2, a0, s2      # Update total string length
    strcat(result_str, line_cnt_buffer)     # Concatenate line count string
    # Convert capital letters count to string and concatenate
    strcat(result_str, capital_str)
    int_to_string(s1, capital_cnt_buffer) # Convert capital count to string
    add  s2, a0, s2      # Update total string length
    strcat(result_str, capital_cnt_buffer)   # Concatenate capital letters count string

    la	a0 result_str	# Save result_str addres in a0
    mv	a1 s2			# Save length in a0
    # Restore context from the stack
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret

