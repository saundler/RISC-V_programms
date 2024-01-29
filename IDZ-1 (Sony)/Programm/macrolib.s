# Decimal output
.macro print_int(%x)
	push (a0)					# Saving a0
	mv a0 %x					# Writing a number to a0
	li a7 1						# Decimal output
	ecall
	pop	(a0)					# Return to original state
.end_macro

# Reading a decimal number
.macro read_int(%x)
   li a7 5						# Reading a decimal number
   ecall
   mv %x, a0					# Move a0 value to %x
.end_macro


# Line output
.macro print_str(%x)
.data
str:	.asciz %x				# Output line
   .text
   	push (a0)					# Saving a0
   	la a0 str					# Writing the address of a string to a0
   	li a7 4						# Line output
   	ecall
	pop	(a0)					# Return to original state
.end_macro

# Character output
.macro print_char(%x)
	push (a0)					# Saving a0
	li a0 %x					# Writing a character to register a0
   	li a7 11					# Character output	
   	ecall
   	pop	(a0)					# Return to original state
.end_macro

# Completing the program
.macro exit
    li a7, 10					# Completing the program	
    ecall
.end_macro

# Storing a given register on the stack
.macro push(%x)
	addi	sp, sp, -4			# Reduce sp by 4
	sw	%x, (sp)				# Save %x at sp
.end_macro

# Popping a value from the top of the stack into a registerr
.macro pop(%x)
	lw	%x, (sp)				# Writing a value to address sp in %x
	addi	sp, sp, 4			# Increase sp by 4
.end_macro
