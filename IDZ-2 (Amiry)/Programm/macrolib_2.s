# Recording input data
.macro write(%left, %right, %epsilon, %three, %neg_two, %two)   
    write_double(%left, ft1)                # %left - the original left border.
    write_double(%right, ft2)        # %right - the original right border.
    write_double(%epsilon, ft3)      # %epsilon - accuracy 0,00000001.
    write_double(%three, ft4)        # Const of equation.
    write_double(%neg_two, ft5)      # Const of equation.
    write_double(%two, ft9)        # Const for division by 2.
    write_int(t2)          # Help-number.
.end_macro

# Finding mid of border
.macro midFind(%mid)
    fadd.d  ft6, ft1, ft2                # Sum of both boundaries.
    fdiv.d  ft6, ft6, ft9                 # Middle of boundaries.
.end_macro

# Saving middle of boundaries
.macro saveMid(%mid, %x)
    write_double(%mid, %x)            # Saving mid as some of borders.
.end_macro

# Finding first root of equation
.macro firstRoot(%root_1)
    save_double(%root_1, ft6)        # Saving first root.
    write_double(%root_1, fs1)        # Writing first root.
    sub     t2, t2, t2          # Sub help-number to find second root.
.end_macro

# Finding second root
.macro secondRoot(%root_2)
    save_double(%root_2, ft6)        # Saving second root.
    write_double(%root_2, fs2)        # Writing second root.
    finish            # Finish program.
.end_macro  

# Establishing the following boundaries
.macro nextRange(%left, %right, %mid)
    write_double(%left, ft1)                # Writing left border.
    write_double(%right, ft2)        # Writing right border.
    midFind(%mid)                # Finding mid.
    saveMid(%mid, ft1)          # Saving mid as first border.
    write_double(%right, ft2)        # Writing right border.
.end_macro

# Finish of program
.macro finish
    print_string("First root = ")      # Output text.
    print_double(fs1)          # Output first root.
    
    newline            # New line
   
    print_string("Second root = ")      # Output text
    print_double(fs2)          # Output second root
        
    end              # The end of the program
.end_macro

# Calculating roots
.macro Calculate
    jal result            # Transition to a subroutine that calculates the roots.
.end_macro