.include "macrolib.s"
.include "macroproglib.s"

.data
.align	2
n: 		.word	0								# ����� ��������� � �������
arr:	.space	40								# ��������� ������ ��� �������

.text
main:
	n_input_macro (n)							
	input_array_macro (arr, n)					# ����� ������������ ����� �������
    output_array_macro (arr, n)					# ����� ������������ ������ �������
    sum_array_macro	(arr, n)					# ����� ������������ ����������� ����� �������
    exit										# ��������� ���������					
