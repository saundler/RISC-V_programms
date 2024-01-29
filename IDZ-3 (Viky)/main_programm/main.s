.include "macro-syscalls.m"
.include "programms-macros.m"
.global main

.eqv    NAME_SIZE 256	
.eqv    TEXT_SIZE 512	

.data
file: 		    .space NAME_SIZE  	# Buffer for file name.
descriptor:		.word 0            	# To store file descriptor.
buffer:			.word 0            	# Buffer for file content..
answer:			.space 100			# Buffer for answer.
answer_length:  .word 0				# Length of answer.
.text
main:    
	# Prompts user for a filename and reads it into file.
    # file - Buffer for file name.
    # NAME_SIZE - size of buffer. 
    # prompt message.
    input_path(file, NAME_SIZE, "Enter file name to read:")

    # Reads the content of the specified file into a dynamically allocated buffer.
    # file - File name. 
    # TEXT_SIZE - size of buffer for reading.
    read(file, TEXT_SIZE)
	# a0 - File descriptor 
	# a1 - Address of the allocated buffer.
	
    la	t0 descriptor		# Load descriptor addres in t0
    sw  a0 (t0)				# Store a0 word by t0 addres
    la	t0 buffer			# Load buffer addres in t0
    sw  a1 (t0)				# Store a1 word by t0 addres

    # Counts the number of capital and lowercase letters in the buffer.
    # buffer - Address of the buffer containing file content.
    counting(buffer, answer, answer_length)

    # Prompts user for a filename and reads it into file.
    # file - Buffer for file name.
    # NAME_SIZE - size of buffer. 
    # prompt message.
    input_path(file, NAME_SIZE, "Input file name for writing:")

    # Writes formatted content to a specified file.
    # file - File name for output.
    # letter_cnt - count of letters.
    # number_cnt - count of numbers.
    write(file, answer, answer_length)
    # a0 - Addres to answer string buffer.
	
	# Give choise to print result string to console or not
    # a0 - Address to answer string buffer 
	console_output(answer)
    exit
