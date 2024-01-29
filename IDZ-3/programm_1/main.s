.include "macrolib.s"
.include "macroproglib.s"
# Include external libraries containing macro definitions.

.global main
# Make 'main' the entry point of the program.

.eqv    NAME_SIZE 256	
.eqv    TEXT_SIZE 512	
# Define constants for buffer sizes.

.data
file_name:      .space NAME_SIZE  # Buffer for file name.
descriptor:		.word 0            # To store file descriptor.
buffer:			.word 0            # Buffer for file content.
line_cnt:		.word 0            # Count of lowercase letters.
capital_cnt:	.word 0            # Count of capital letters.
# Data section declaration for storing various values.

.text
main:    
	# input_filename: Prompts user for a filename and reads it into 'file_name'.
    # Parameters: Buffer for file name, size of buffer, prompt message.
    input_filename(file_name, NAME_SIZE, "Enter the path to the file to read:")

    # read_file: Reads the content of the specified file into a dynamically allocated buffer.
    # Parameters: File name, size of buffer for reading.
    # Returns: File descriptor in a0, address of the allocated buffer in a1.
    read_file(file_name, TEXT_SIZE)

    # Store the returned file descriptor and buffer address in 'descriptor' and 'buffer'.
    la	t0, descriptor
    sw  a0, (t0)
    la	t0, buffer
    sw  a1, (t0)

    # letter_counting: Counts the number of capital and lowercase letters in the buffer.
    # Parameter: Address of the buffer containing file content.
    # Returns: Capital letters count in a0, lowercase letters count in a1.
    letter_counting(buffer)

    # Store the counts of capital and lowercase letters in 'capital_cnt' and 'line_cnt'.
    la	t0, capital_cnt
    sw	a0, (t0)
    la	t0, line_cnt
    sw	a1, (t0)

    # input_filename: Prompts user for a filename to write the output and reads it into 'file_name'.
    # Parameters: Buffer for file name, size of buffer, prompt message.
    input_filename(file_name, NAME_SIZE, "Input path to file for writing:")

    # result_string: Generate a result string for output and writting
    # Parameters: Count of lowercase letters, count of capital letters.
    # Returns: Address to result string buffer, and length of this string
    result_string(line_cnt, capital_cnt)
    mv 	s0, a0
    mv  s1, a1
    
    # write_file: Writes formatted content to a file.
    # Parameters: Symbol representing the variable holding the file name, 
    #       	  address to result buffer, length of this string.
    write_file(file_name, s0, s1)
    
    # print_result: Give choise to print result string to console or not
    # Parameters: Adress to result string buffer 
    # This subroutine does not return any values.
	print_result(s0)
	
    # exit: Terminates the program.
    exit
