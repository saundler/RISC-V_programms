.include "macro-syscalls.m"
.include "programms-macros.m"
.global main

.eqv    TEXT_SIZE 512	

.data
test_1: 		.asciz "../data/test_1.txt"
result_1:		.asciz "../data/result_1.txt"
test_2: 		.asciz "../data/test_2.txt"
result_2:		.asciz "../data/result_2.txt"
test_3: 		.asciz "../data/test_3.txt"
result_3:		.asciz "../data/result_3.txt"
descriptor:		.word 0            	# To store file descriptor.
buffer:			.word 0            	# Buffer for file content..
answer_length:  .word 0				# Length of answer.
answer:			.space 256			# Buffer for answer.

.text
main:    
SET_1:
    # Reads the content of the specified file into a dynamically allocated buffer.
    read(test_1, TEXT_SIZE)
    la	t0 descriptor		# Load descriptor addres in t0
    sw  a0 (t0)				# Store a0 word by t0 addres
    la	t0 buffer			# Load buffer addres in t0
    sw  a1 (t0)				# Store a1 word by t0 addres
    # Counts the number of capital and lowercase letters in the buffer.
    counting(buffer, answer, answer_length)
    # Writes formatted content to a specified file.s.
    write(result_1, answer, answer_length)
    la  t0 answer
    sw	zero, (t0)

SET_2:
    # Reads the content of the specified file into a dynamically allocated buffer.
    read(test_2, TEXT_SIZE)
    la	t0 descriptor		# Load descriptor addres in t0
    sw  a0 (t0)				# Store a0 word by t0 addres
    la	t0 buffer			# Load buffer addres in t0
    sw  a1 (t0)				# Store a1 word by t0 addres
    # Counts the number of capital and lowercase letters in the buffer.
    counting(buffer, answer, answer_length)
    # Writes formatted content to a specified file.s.
    write(result_2, answer, answer_length)
    la  t0 answer
    sw	zero, (t0)
SET_3:
    # Reads the content of the specified file into a dynamically allocated buffer.
    read(test_3, TEXT_SIZE)
    la	t0 descriptor		# Load descriptor addres in t0
    sw  a0 (t0)				# Store a0 word by t0 addres
    la	t0 buffer			# Load buffer addres in t0
    sw  a1 (t0)				# Store a1 word by t0 addres
    # Counts the number of capital and lowercase letters in the buffer.
    counting(buffer, answer, answer_length)
    # Writes formatted content to a specified file.s.
    write(result_3, answer, answer_length)
    la  t0 answer
    sw	zero, (t0)
    exit
