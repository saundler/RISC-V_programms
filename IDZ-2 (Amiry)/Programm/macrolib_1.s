# Writing a double-value
.macro write_double(%x, %y)
  la  t0, %x       		 	# Loading the address of the %x variable into the t0 register.
  fld     %y, 0(t0)      	# Loading the %x value into the floating point register %y.  
.end_macro

# Writing a int-value
.macro write_int(%x)
  li     %x, 1       	 	# Assigning the value of 1 to the %x register.
.end_macro

# Saving a double-value
.macro save_double(%x, %y)
  la  t0, %x        		# Loading the address of the %x variable into the t0 register.
  fsd     %y, 0(t0)      	# Store a double %x to memory %y.    
.end_macro

# Print double
.macro print_double(%x)
  li  a7, 3             	# System call ¹3 - print a double precision floating point number.
  fmv.d  fa0, %x        	# Set fa0 to contents of %x.
  ecall
.end_macro

# String output
.macro print_string(%x)
.data 
temp: .asciz %x
.text
  la  a0, temp           	# Line feed. 
         li  a7, 4     		# System call ¹4 - print a null-terminated string to the console.
         ecall
.end_macro 

# New line
.macro newline
   print_string("\n")		# Print new line.
.end_macro

# Completing the program
.macro end
  li     a7, 10    			# System call ¹10 - exit the program with code 0.
  ecall
.end_macro
