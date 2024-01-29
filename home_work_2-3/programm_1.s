.data
    arg01:  .asciz "Input dividend: "
    arg02:  .asciz "Input the divisor: "
    result01: .asciz "Result = "
    result02: .asciz "Remainder = "
    ln:     .asciz "\n"
    wronginput: .asciz "ERROR!!! divisor cannot be 0"
.text
	la 	a0, arg01   # ��������� ��� ����� ������� �����
    	li 	a7, 4       # ��������� ����� �4
        ecall
        li      a7 5        # ��������� ����� �5 � ������ ���������� �����
        ecall               # ��������� � � �������� a0
        mv      t0 a0       # ��������� ��������� � t0

        la 	a0, arg02   # ��������� ��� ����� ������� �����
        li 	a7, 4       # ��������� ����� �4
        ecall
        li      a7 5        # ��������� ����� �5 � ������ ���������� �����
        ecall               # ��������� � � �������� a0
        mv      t1 a0       # ��������� ��������� � t1
        
        if_0:					# �������� ������� �� ����
  	   bnez		t1, if_ddgz_and_dvgz	
  	   la 		a0, wronginput     	# ��������� ��� ���������� ����������
           li		a7, 4               	# ��������� ����� �4
           ecall
 	   li   	a7 10              	# ��������� ����� �10 � ������� ���������
           ecall
           
	if_ddgz_and_dvgz:			# ������� ���� �������� � ������� �������������
 	   bltz 	t0, if_ddlz_and_dvlz
 	   bltz	t1, if_ddlz_and_dvlz
  	   while1:
   	      bgt	t1, t0, end_while1	
   	      sub	t0, t0, t1		# ��������� �� �������� ��������
   	      addi	t2, t2, 1		# ����������� � ���������� �������
   	      j    while1
	   end_while1: 
  	   j    end_if 
	if_ddlz_and_dvlz:			# ������� ���� �������� � ������� �������������
  	   bgtz	t0, if_ddgz_and_dvlz 
  	   bgtz 	t1, if_ddgz_and_dvlz  
   	   while2:
   	      bgt	t0, t1, end_while2
   	      sub	t0, t0, t1		# ��������� �� �������� ��������
   	      addi	t2, t2, 1		# ����������� � ���������� �������
   	      j    while2	
	   end_while2:
   	   j    end_if
   	if_ddgz_and_dvlz:			# ������� ���� �������� �������������, � ������� �������������
  	   bgtz 		t1, else
  	   addi 		a1, a1, -1	# ������������ �������� �1 �������� -1
  	   mul 		t1, t1, a1		# ������ ����� � ��������
  	   while3:
   	      bgt   	t1, t0, end_while3
   	      sub    	t0, t0, t1		# ��������� �� �������� ��������
   	      add   	t2, t2, a1		# ��������� �� ���������� �������
    	      j    while3
	   end_while3:
   	   j    end_if  
	 else:					# ������� ���� �������� �������������, � ������� �������������
   	   addi 		a1, a1, -1	# ������������ �������� �1 �������� -1
  	   mul 		t0, t0, a1		# ������ ����� � ��������
  	   while4:
   	      bgt   	t1, t0, end_while4
   	      sub    	t0, t0, t1		# ��������� �� �������� ��������
   	      add   	t2, t2, a1		# ��������� �� ���������� �������
   	      j    while4
	   end_while4:
	   mul 		t0, t0, a1		# ������ ����� � �������
	 end_if:
        
        la 	a0, result01     # ��������� ��� ���������� ����������
        li 	a7, 4            # ��������� ����� �4
        ecall
        mv      a0, t2      
        li      a7 1             # ��������� ����� �1 � ������� ���������� �����
        ecall

        la 	a0, ln           # ������� ������
        li	a7, 4            # ��������� ����� �4
        ecall
        
        la	a0, result02     # ��������� ��� ���������� ����������
        li	a7, 4            # ��������� ����� �4
        ecall
        mv	a0, t0
        li	a7 1             # ��������� ����� �1 � ������� ���������� �����
        ecall
        
        la	a0, ln           # ������� ������
        li	a7, 4            # ��������� ����� �4
        ecall

        li      a7 10      	 # ��������� ����� �10 � ������� ���������
        ecall
