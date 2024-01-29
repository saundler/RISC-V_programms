.include "macrolib.s"
.include "macroproglib.s"

.data
x_1: 		.double	0.0			# The number from which calculations are based
x_2: 		.double	3.14		# The number from which calculations are based
x_3: 		.double	-3.14		# The number from which calculations are based
x_4: 		.double	14			# The number from which calculations are based
x_5: 		.double	-14			# The number from which calculations are based
sin_x: 		.double	0			# Sine of number x
cos_x: 		.double	0			# Cosine of number x
precision: 	.double 0.00005		# Calculation accuracy value

.text
test_1:
	print_str("1) x = ")		# Line output
	fld 	ft0 x_1 t0			# Load the ft0 register with the x_1 value
	print_double(ft0)			# Printing numbers with double type
	newline						# Newline
	# Calculating sine using Taylor series
	sin_taylor_macro(x_1, precision, sin_x)
	# Calculating cosine using Taylor series
	cos_taylor_macro(x_1, precision, cos_x)
	# Calculating tangent by dividing sine by cosine
	tan_macro(sin_x, cos_x)	
	newline						# Newline
test_2:
	print_str("2) x = ")		# Line output
	fld 	ft0 x_2 t0			# Load the ft0 register with the x_2 value
	print_double(ft0)			# Printing numbers with double type
	newline						# Newline
	# Calculating sine using Taylor series
	sin_taylor_macro(x_2, precision, sin_x)
	# Calculating cosine using Taylor series
	cos_taylor_macro(x_2, precision, cos_x)
	# Calculating tangent by dividing sine by cosine
	tan_macro(sin_x, cos_x)	
	newline						# Newline	
test_3:
	print_str("3) x = ")		# Line output
	fld 	ft0 x_3 t0			# Load the ft0 register with the x_3 value
	print_double(ft0)			# Printing numbers with double type
	newline						# Newline
	# Calculating sine using Taylor series
	sin_taylor_macro(x_3, precision, sin_x)
	# Calculating cosine using Taylor series
	cos_taylor_macro(x_3, precision, cos_x)
	# Calculating tangent by dividing sine by cosine
	tan_macro(sin_x, cos_x)	
	newline						# Newline
test_4:
	print_str("4) x = ")		# Line output
	fld 	ft0 x_4 t0			# Load the ft0 register with the x_4 value
	print_double(ft0)			# Printing numbers with double type
	newline						# Newline
	# Calculating sine using Taylor series
	sin_taylor_macro(x_4, precision, sin_x)
	# Calculating cosine using Taylor series
	cos_taylor_macro(x_4, precision, cos_x)
	# Calculating tangent by dividing sine by cosine
	tan_macro(sin_x, cos_x)
	newline						# Newline	
test_5:
	print_str("5) x = ")		# Line output
	fld 	ft0 x_5 t0			# Load the ft0 register with the x_5 value
	print_double(ft0)			# Printing numbers with double type
	newline						# Newline
	# Calculating sine using Taylor series
	sin_taylor_macro(x_5, precision, sin_x)
	# Calculating cosine using Taylor series
	cos_taylor_macro(x_5, precision, cos_x)
	# Calculating tangent by dividing sine by cosine
	tan_macro(sin_x, cos_x)					
    exit
