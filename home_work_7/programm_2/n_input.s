.include "macrolib.s"
.global n_input

.text
n_input:     
	push (t0)
	print_str ("Input array lenght n = ")		# ��������� ����� ������ �������
	read_int (a0)								# ���� ������ �������
	blez	a0 fail								# �� ������, ���� ������ 0
	li 		t0 10								# ������ ����� 10 � ������� t2
	bgt 	a0 t0 fail							# �� ������, ���� ������ 10
	pop (t0)
	ret
	
fail:
    print_str ("Incorrect input!!!\n")			# ����� ������ ������������ �� ������
    exit										# ��������� ���������
