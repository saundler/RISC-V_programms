# Macro Descriptions

# ==================================================================================
# read_file Macro
# ==================================================================================
# Reads content from a file into a dynamically allocated buffer.
# Arguments:
#   %file_name  - Symbol representing the variable holding the file name.
#   %NAME_SIZE  - The maximum size for the file name.
#   %TEXT_SIZE  - The size of the buffer to be allocated for reading the file.
.macro read_file(%file_name, %TEXT_SIZE)
    la a1, %file_name  # Load the address of the file name into a1
    li a2, %TEXT_SIZE 
    jal read_file      # Jump to the read_file function
.end_macro

# ==================================================================================
# letter_counting Macro
# ==================================================================================
# Counts the number of capital and lowercase letters in a string.
# Arguments:
#   %buffer - Symbol representing the variable holding the string buffer.
.macro letter_counting(%buffer)
    lw a0, %buffer     # Load the address of the buffer into a0
    jal letter_counting # Jump to the letter_counting function
.end_macro

# ==================================================================================
# str_reverse Macro
# ==================================================================================
# Reverses a null-terminated string in place.
# Arguments:
#   %buffer - Symbol representing the variable holding the string buffer.
.macro str_reverse(%buffer)
    mv a0, %buffer     # Move the buffer address to a0
    jal str_reverse    # Jump to the str_reverse function
.end_macro

# ==================================================================================
# int_to_string Macro
# ==================================================================================
# Converts an integer to a string.
# Arguments:
#   %num        - Symbol representing the variable holding the integer.
#   %cnt_buffer - Symbol representing the variable for the output buffer.
.macro int_to_string(%num, %cnt_buffer)
    mv a0, %num        # Move the integer to a0
    la a1, %cnt_buffer # Load the address of the output buffer into a1
    jal int_to_string  # Jump to the int_to_string function
.end_macro

# ==================================================================================
# strcat Macro
# ==================================================================================
# Concatenates two strings.
# Arguments:
#   %str        - Symbol representing the variable holding the first string.
#   %cnt_buffer - Symbol representing the variable holding the second string.
.macro strcat(%str, %cnt_buffer)
    la a0, %str        # Load the address of the first string into a0
    la a1, %cnt_buffer # Load the address of the second string into a1
    jal strcat         # Jump to the strcat function
.end_macro

# ==================================================================================
# result_string Macro
# ==================================================================================
# Generate a result string for output and writting
# Arguments:
#   %line_cnt    - Symbol representing the variable holding the line count.
#   %capital_cnt - Symbol representing the variable holding the capital letter count.
# return:
# 	a0 - address to result buffer.
#	a1 - length of this string.
.macro result_string(%line_cnt, %capital_cnt)
    lw a0, %line_cnt    	# Load the line count into a0
    lw a1, %capital_cnt 	# Load the capital letter count into a1
    jal result_string      # Jump to the write_file function
.end_macro

# ==================================================================================
# write_file Macro
# ==================================================================================
# Writes formatted content to a file.
# Arguments:
#   %file_name 	   - Symbol representing the variable holding the file name.
#   %result_string - Address to result buffer.
#   %length        - Length of this string.
.macro write_file(%file_name, %result_string, %length)
	la a0, %file_name		# Load the address of the file name into a0
    mv a1, %result_string   # Load the address of result string into a1
    mv a2, %length    		# Load the length of result strint into a2
    jal write_file      	# Jump to the write_file function
.end_macro

# ==================================================================================
# print_result Macro
# ==================================================================================
# Give choise to print result string to console or not
# Arguments:
#   %result_string - Addres to result string buffer.
.macro print_result(%result_string)
    mv a0, %result_string   # Load the address of the result_string
    jal print_result      	# Jump to the write_file function
.end_macro


# ==================================================================================
# input_filename Macro
# ==================================================================================
# Prompts the user to input a filename and reads it into a specified buffer.
# Arguments:
#   %file_name - Symbol representing the buffer where the input filename will be stored.
#   %NAME_SIZE - Symbol representing the size of the file_name buffer.
#   %message   - String parameter for the prompt message displayed to the user.
# input_filename Macro: Prompts the user for a filename and stores it in a buffer.
.macro input_filename(%file_name, %NAME_SIZE, %message)
    .data 
    message: 	.asciz %message  # Store the prompt message.

    .text
    la a1, %file_name           # Load buffer address for storing the filename.
    li a2, %NAME_SIZE           # Load buffer size.
    la a3, message              # Load prompt message address.
    jal input_filename          # Call subroutine to read user input.
.end_macro                     # End of macro definition.


