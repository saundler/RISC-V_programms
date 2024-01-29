.include "macrolib.s"
.include "functionslib.s"

.data
.align	2
source_length: 		.word	0		# Long source array
source_arr:	.space	40				# Source array
result_length: 		.word	0		# Length of the resulting array
result_arr:	.space 	40				# Resulting array

.text
main:
	# Entering the length of the source array
	input_length(source_length)
	# Entering elements of the source array						
	input_array(source_arr, source_length)
	# Outputting the elements of the original array
    output_array(source_arr, source_length, "Source array: ")	
    # Processing the original array and writing the resulting one
    array_fix(source_arr, source_length, result_arr, result_length)
    # Printing the elements of the resulting array
    output_array(result_arr, result_length, "Result array: ")					
    exit							# Completing the program		
