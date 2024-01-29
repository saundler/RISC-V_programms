 .macro	n_input_macro (%x)
	push (t0)
	jal n_input
	la 	t0 %x									# ����� n � t2
	sw	a0 (t0)									# �������� n � ������ �� ��������
	pop (t0)
.end_macro

 .macro	input_array_macro(%x, %y)
 	sep
 	push (t0)
 	push (t1)									# ����� ������ �����������
	la  t0 %x									# ��������� �������� �������
	lw	t1 %y
	jal input_array
	pop (t1)
	pop (t0)
.end_macro

.macro	output_array_macro (%x, %y)
	sep											# ����� ������ �����������
	push (t0)
 	push (t1)
	la  t0 %x									# ��������� �������� �������
	lw	t1 %y
	jal output_array
	pop (t1)
	pop (t0)
.end_macro

.macro	sum_array_macro (%x, %y)
	push (t0)
 	push (t1)
	la  t0 %x									# ��������� �������� �������
	lw	t1 %y
	jal sum_array
	print_str ("Sum of array elements: ")		# ����� ������ � ���������� ����� ���������
    print_int (a0)								# ����� ����� ���������
    newline										# ������� �� ��������� ������
    print_str ("Number of summed elements: ")	# ����� ������ � ���������� ���������� ���������������� ���������
	lw		t2, %y								# ����� ��������� ������� 
	sub 	t2, t2, t1							# ���������� ���������� ���������������� ���������
    print_int (t2)	 	   						# ����� ���������� ���������������� ���������
    pop (t1)
	pop (t0)
.end_macro