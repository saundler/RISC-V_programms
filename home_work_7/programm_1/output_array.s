.include "macrolib.s"
.global output_array

.text
output_array:
	print_str ("Array: ")			# ����� ������ � ���������� ���������� �������
loop:
    lw		t2 (t0)					# ������ �������� ������� � ������� a2
    print_int (t2)					# ����� �������� �������
	print_char (' ')				# ����� �������
    addi    t0 t0 4					# �������� ����� �� ������ ����� � ������	
    addi    t1 t1 -1				# �������� ���������� ���������� ��������� �� 1
    bnez    t1 loop					# ���� �������� ������ 0
finish:
	newline							# ������� �� ��������� ������
    ret								# ������� � �������� ���������
