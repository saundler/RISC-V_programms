.include "macrolib.s"
.global input_array

.text
input_array:
loop:   
	print_str ("Input element value: ")		# ����� ������ � ���������� ����� ��������
	read_int (t2)							# ���� ����� � ������� � t2
	sw      t2 (t0)							# ������ ����� �� ������ � t0
    addi    t0 t0 4							# �������� ����� �� ������ ����� � ������
    addi    t1 t1 -1						# �������� ���������� ���������� ��������� �� 1
    bnez    t1 loop							# ���� �������� ������ 0
	ret										# ������� � �������� ���������
