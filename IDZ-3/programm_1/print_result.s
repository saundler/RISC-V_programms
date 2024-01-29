.include "macrolib.s"
.global print_result 


# Arguments:
# a0 - Adress to result string buffer

.text
print_result:
	push(s0)	# Save s0 regid=ster on stack
	
	mv	s0 a0	# Mpve a0 data in s0s
    # Prompt user for console output choice
    print_str("To output the results to the console, press Y otherwise N: ")
    # Handle user input for console output
    li   t1, 78          # ASCII for 'N'
    li   t2, 110         # ASCII for 'n'
    li   t3, 89          # ASCII for 'Y'
    li   t4, 121         # ASCII for 'y'
loop:
    li   a7, 12          # System call for reading a character
    ecall
    mv   t0, a0          # Move read character to t0
if_n:
    beq  t0, t1, finish   # Check for 'N'
    beq  t0, t2, finish   # Check for 'n'    
if_y:
    beq  t0, t3, end_loop # Check for 'Y'
    beq  t0, t4, end_loop # Check for 'y'
    print_str("\nnon-existent command, re-enter: ")
    j    loop
end_loop:
    newline
    li 		a7 4			# System call for console output string
    mv		a0 s0
    ecall					# Output
finish:
    ret                  # Return from the function
