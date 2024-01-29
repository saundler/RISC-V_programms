.include "macrolib.s"
.include "macroproglib.s"

.global main

.eqv    TEXT_SIZE 512

.data
test_1: 	.asciz "../tests/test_1.txt"
ans_1:		.asciz "../answers/ans_1.txt"
test_2: 	.asciz "../tests/test_2.txt"
ans_2:		.asciz "../answers/ans_2.txt"
test_3: 	.asciz "../tests/test_3.txt"
ans_3:		.asciz "../answers/ans_3.txt"
test_4: 	.asciz "../tests/test_4.txt"
ans_4:		.asciz "../answers/ans_4.txt"
test_5: 	.asciz "../tests/test_5.txt"
ans_5:		.asciz "../answers/ans_5.txt"

.data
descriptor:   .word 0            # Variable to store the file descriptor
buffer:       .word 0            # Buffer to hold file content
line_cnt:     .word 0            # Variable to count lowercase letters
capital_cnt:  .word 0            # Variable to count capital letters

.text
main:
# Test case 1
    read_file(test_1, TEXT_SIZE)  # Read content of test_1 file
    la  t0, descriptor            # Load address of descriptor variable
    sw  a0, (t0)                  # Store file descriptor in descriptor
    la  t0, buffer                # Load address of buffer variable
    sw  a1, (t0)                  # Store file content in buffer
    letter_counting(buffer)       # Count letters in the buffer
    la  t0, capital_cnt
    sw  a0, (t0)                  # Store count of capital letters
    la  t0, line_cnt
    sw  a1, (t0)                  # Store count of lowercase letters
    result_string(line_cnt, capital_cnt) # Prepare result string
    mv  s0, a0
    mv  s1, a1
    write_file(ans_1, s0, s1)     # Write result string to ans_1 file
    sw  zero, (s0)                # Clear content at the address in s0
    
# Test case 2
    read_file(test_2, TEXT_SIZE)  # Read content from test_2 file
    la  t0, descriptor            # Load address of 'descriptor'
    sw  a0, (t0)                  # Store file descriptor in 'descriptor'
    la  t0, buffer                # Load address of 'buffer'
    sw  a1, (t0)                  # Store address of file content in 'buffer'
    letter_counting(buffer)       # Count letters in buffer
    la  t0, capital_cnt
    sw  a0, (t0)                  # Store count of capital letters
    la  t0, line_cnt
    sw  a1, (t0)                  # Store count of lowercase letters
    result_string(line_cnt, capital_cnt) # Prepare result string
    mv  s0, a0
    mv  s1, a1
    write_file(ans_2, s0, s1)     # Write result to ans_2 file
    sw  zero, (s0)                # Clear the buffer

# Test case 3
    read_file(test_3, TEXT_SIZE)  # Read content from test_3 file
    la  t0, descriptor            # Load address of 'descriptor'
    sw  a0, (t0)                  # Store file descriptor in 'descriptor'
    la  t0, buffer                # Load address of 'buffer'
    sw  a1, (t0)                  # Store address of file content in 'buffer'
    letter_counting(buffer)       # Count letters in buffer
    la  t0, capital_cnt
    sw  a0, (t0)                  # Store count of capital letters
    la  t0, line_cnt
    sw  a1, (t0)                  # Store count of lowercase letters
    result_string(line_cnt, capital_cnt) # Prepare result string
    mv  s0, a0
    mv  s1, a1
    write_file(ans_3, s0, s1)     # Write result to ans_3 file
    sw  zero, (s0)                # Clear the buffer

# Test case 4
    read_file(test_4, TEXT_SIZE)  # Read content from test_4 file
    la  t0, descriptor            # Load address of 'descriptor'
    sw  a0, (t0)                  # Store file descriptor in 'descriptor'
    la  t0, buffer                # Load address of 'buffer'
    sw  a1, (t0)                  # Store address of file content in 'buffer'
    letter_counting(buffer)       # Count letters in buffer
    la  t0, capital_cnt
    sw  a0, (t0)                  # Store count of capital letters
    la  t0, line_cnt
    sw  a1, (t0)                  # Store count of lowercase letters
    result_string(line_cnt, capital_cnt) # Prepare result string
    mv  s0, a0
    mv  s1, a1
    write_file(ans_4, s0, s1)     # Write result to ans_4 file
    sw  zero, (s0)                # Clear the buffer
    
# Test case 5
    read_file(test_5, TEXT_SIZE)  # Read content from test_5 file
    la  t0, descriptor            # Load address of 'descriptor'
    sw  a0, (t0)                  # Store file descriptor in 'descriptor'
    la  t0, buffer                # Load address of 'buffer'
    sw  a1, (t0)                  # Store address of file content in 'buffer'
    letter_counting(buffer)       # Count letters in buffer
    la  t0, capital_cnt
    sw  a0, (t0)                  # Store count of capital letters
    la  t0, line_cnt
    sw  a1, (t0)                  # Store count of lowercase letters
    result_string(line_cnt, capital_cnt) # Prepare result string
    mv  s0, a0
    mv  s1, a1
    write_file(ans_5, s0, s1)     # Write result to ans_5 file
    sw  zero, (s0)                # Clear the buffer
    exit
