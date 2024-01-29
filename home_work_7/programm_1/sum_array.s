.include "macrolib.s"
.global sum_array

.text
sum_array:     
	push (a1)								# ������ �������� �������� a1
	push (a2)								# ������ �������� �������� a2
	li 		a0 0							# ������ 0 � ������� a0
	li 		a1 2147483647					# ������ ����������� ���������� �����
	li		a2 -2147483648					# ������ ���������� ���������� �����             
loop:  
	lw		t2 (t0)							# ������ �������� ������� � ������� a2
	if_above:
	sub 	a1 a1 t2						# �������� �� ����������� ���������� ����� t2
	bgt 	a0 a1 fail_above				# �������� �� ������������� ������
	if_below:
	sub 	a2 a2 t2						# �������� �� ���������� ���������� ����� t2
	blt 	a0 a2 fail_below				# �������� �� ������������� �����
	add		a0 a0 t2						# �������� � ����� ��������� ������� ����� �������
    addi    t0 t0 4							# �������� ����� �� ������ ����� � ������	
    addi    t1 t1 -1						# �������� ���������� ���������� ��������� �� 1
    bnez    t1 loop							# ���� �������� ������ 0
final:
	pop (a2)								# ������� � ����������� ��������
	pop (a1)								# ������� � ����������� ��������
    ret										# ������� � �������� ���������
    
fail_above:
    print_str ("�verflow from above!!!\n")	# ����� ������ ������������ �� ������
    ret										# ������� � �������� ���������
fail_below:
    print_str ("�verflow from below!!!\n")  # ����� ������ ������������ �� ������
    ret										# ������� � �������� ���������