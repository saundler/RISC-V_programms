.include "macrolib.s"
.include "macroproglib.s"

.data
x: 			.double	0			# The number from which calculations are based
sin_x: 		.double	0			# Sine of number x
cos_x: 		.double	0			# Cosine of number x
precision: 	.double 0.00005		# Calculation accuracy value

.text
main:
	# Entering the number x and predicting it modulo the number PI
	# Accepts a memory address at x for later writing
	x_input_macro(x)
	
	# Calculating sine using Taylor series
	# Accepts x and precision addresses for calculations as well as sin_x for writing values
	sin_taylor_macro(x, precision, sin_x)
	
	# Calculating cosine using Taylor series
	# Accepts x and precision addresses for calculations and cos_x for writing values
	cos_taylor_macro(x, precision, cos_x)
	
	# Calculating tangent by dividing sine by cosine
	# Accepts addresses on sin_x and cos_x to calculate the tangent of x
	tan_macro(sin_x, cos_x)
	
	# Exit the program
    exit										
