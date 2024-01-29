.include "macrolib_1.s"
.include "macrolib_2.s"
.global result

.data
left:       .double -1.0                 				# The original left border.
right:      .double 1.0                  				# The original right border.
mid:        .double 0.0                  				# Middle of boundaries.
epsilon:    .double 0.00000001           				# Accuracy 0,00000001.
three:      .double 3.0                  				# Const of equation.
neg_two:    .double -2.0                 				# Const of equation.
two:        .double 2.0          						# Const for division by 2.
root_1:     .double 0.0          						# The desired root.
root_2:     .double 0.0          						# The desired root.

.text

result:
    write(left, right, epsilon, three, neg_two, two) 	 # Recording input data.

    midFind(mid)										 # Finding mid.
    saveMid(mid, ft2)          							 # Saving mid.
    j bisect_loop          								 # Going to fing first root.

    first:            
        firstRoot(root_1)        						 # Saving first root.

    nextRange(left, right, mid)     					 # Finding next range.
    j bisect_loop          								 # Going to find second root.

    second:
       secondRoot(root_2)        # Saving second root.

    bisect_loop:
       fadd.d    ft6, ft1, ft2                # ft6 = ft1 + ft2
       fdiv.d    ft6, ft6, ft9               # ft6 = (ft1 + ft2) / 2

       # Calculation of the function value at the midpoint of the interval: 3 * x^2 - 2.
       fmul.d    ft7, ft6, ft6                # ft7 = ft6^2
       fmul.d    ft7, ft7, ft4               # ft7 = 3 * ft6^2
       fadd.d    ft7, ft7, ft5                # ft7 = 3 * ft6^2 - 3

       fabs.d    ft8, ft7                    # The module of the function value.
       flt.d     t1, ft8, ft3                # |f(mid)| < epsilon?
       bnez   t2, result_1        # Help for finding first root.
       beqz  t2, result_2        # Help for finding second root.
       result_1:
            bnez      t1, first              # If the value of the function is small enough, we're going to save first root.
      j continue
       result_2:
            bnez    t1, second            # If the value of the function is small enough, we're going to save second root.
       # Selecting a subinterval for the next iteration.
       continue:
           fmul.d    ft7, ft7, ft1             # ft8 = f(mid) * f(left)   
           flt.d     t1, ft0, ft7               # t1 = (f(mid) * f(left) < 0)
           bnez      t1, update_right           # If f(mid) * f(left) < 0, root between left and mid.
    
           fmv.d     ft1, ft6                   # Otherwise, update. 
           j         bisect_loop                # Moving on to the next iteration.

       update_right:
           fmv.d    ft2, ft6                  # Update.
           j         bisect_loop                # Moving on to the next iteration.

    finish            # Finish.