# Decimal output
.macro print_int (%x)
	li a7 1							# System call 1 - output decimal number
	mv a0 %x						# Move the value of %x to register a0
	ecall
.end_macro

# Printing numbers with double type
.macro print_double (%x)
	li a7 3							# System call 3 - output double number
	fmv.d fa0 %x					# Move the value of %x to register fa0 
	ecall
.end_macro

# Reading a decimal number
.macro read_int(%x)
   	li a7 5							# System call 5 - read decimal number
  	ecall
   	mv %x, a0						# Move a0 value to %x
.end_macro


# Reading a number with type double
.macro read_double(%x)
   	li a7 7							# System call 7 - reading a number with type double
   	ecall
   	fmv.d %x fa0					# Move the value of %x to register fa0 
.end_macro


# Line output
.macro print_str (%x)
.data
str:	.asciz %x					# Output line
.text
   	push (a0)						# Saving the value of register a0 to memory
   	li a7 4							# System call 4 - output string
   	la a0 str						# Load the address of a string into register a0
   	ecall
   	pop	(a0)						# Return to previous date
.end_macro

# Sign output
.macro print_char(%x)
	push (a0)						# Saving the value of register a0 to memory
   	li a7 11						# System call 11 - symbol output
   	li a0 %x						# Let's assign the symbol %x to register a0
   	ecall
   	pop	(a0)						# Return to previous date
.end_macro

# Newline
.macro newline
   print_char('\n')					# Derivation of the '\n' symbol
.end_macro

# Outputting the delimiter string
.macro sep
   print_str ("----------\n")		# Output the line "----------\n"
.end_macro

# Completing the program
.macro exit
    li a7, 10						# System call 10 - program termination
    ecall
.end_macro

# Storing a given int register on the stack
.macro push(%x)
	addi	sp, sp, -4				# Decrease register sp by 4
	sw	%x, (sp)					# Save %x at sp
.end_macro

# Storing a given double register on the stack
.macro pushd(%x)
    addi    sp, sp, -8      		# Decrease register sp by 8
    fsd     %x, 0(sp)   		 	# Save %x at sp
.end_macro

# Popping a int value from the top of the stack into a register
.macro pop(%x)
	lw	%x, (sp)					# Writing a value to address sp in %x
	addi	sp, sp, 4				# Increase register sp by 4
.end_macro

# Popping a double value from the top of the stack into a register
.macro popd(%x)
    fld     %x, 0(sp)  				# Writing a value to address sp in %x
    addi    sp, sp, 8       		# Increase register sp by 8
.end_macro
