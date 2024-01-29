# Reads file content into a dynamically allocated buffer
.macro read(%file %TEXT_SIZE)
    la a1 %file  			# Address of the file name
    li a2 %TEXT_SIZE  		# Size of the buffer for reading
    jal read      			# Call read_file function
.end_macro

# Counts the number of capital and lowercase letters in a string
.macro counting(%buffer, %answer, %answer_length)
    lw a0 %buffer     		# Address of the string buffer
    la a1 %answer
    jal counting       		# Call counting function
    la t0 %answer_length 
    sw a0 (t0)
.end_macro

# Reverses a null-terminated string in place
.macro rev_str(%buffer)
    mv a0 %buffer     		# Address of the string buffer
    jal rev_str        		# Call str_reverse function
.end_macro

# Converts an integer to a string
.macro ITOS(%num %cnt_buffer)
    mv a0 %num        		# Integer to convert
    la a1 %cnt_buffer 		# Address of the output buffer
    jal ITOS           		# Call int_to_string function
.end_macro

# Concatenates two strings
.macro cat_str(%str %buffer)
    mv a0 %str        		# Address of the first string
    la a1 %buffer 			# Address of the second string
    jal cat_str        		# Call strcat function
.end_macro

# Writes formatted content to a file
.macro write(%file %answer %answer_length)
    la a0 %file   			# Address of the file
    la a1 %answer    		# Load the address of result string into a1
    lw a2 %answer_length 	# Load the length of result strint into a2
    jal write      			# Call write_file function
.end_macro

# Prompts user for a filename and stores it in a buffer
.macro input_path(%file %NAME_SIZE %str)
.data 
 message: 	.asciz %str  	# Prompt message
.text
    la a1 %file           	# Address of filename buffer
    li a2 %NAME_SIZE        # Size of the filename buffer
    la a3 message           # Address of prompt message
    jal input_path          # Call input_filename subroutine
.end_macro

# Give choise to print result string to console or not
.macro console_output(%str)
    la a0, %str   			# Load the address of the result_string
    jal console_output     	# Jump to the write_file function
.end_macro
