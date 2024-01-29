.include "macrolib.s"

.eqv 	SIZE 16
.data
test_str1:	.asciz ""
test_str2:	.asciz "Hello world!\n"
test_str3:	.asciz "Bye world!\n"
input:		.space SIZE
result:		.space SIZE

.global main

.text
main:
test_1:
	# ������������ ������
	strcpy (result, test_str1)
	# �����  ������
	print_lstr (result)
test_2:	
	# ������������ ������
	strcpy (result, test_str2)
	# �����  ������
	print_lstr (result)
test_3:	
	# ������������ ������
	strcpy (result, test_str3)
	# �����  ������
	print_lstr (result)
test_4:	
	# �����  ������
	print_str ("Input the string with length <= 15:\n")
	
	li	a7 8						# 8 ��������� ����� - ������ ������
	la	a0 input					# �������� ������ ��� ������ ������
	li	a1 SIZE						# ���������� ������ ������
	ecall
	
	print_str ("\nResult:\n")
	# ������������ ������
	strcpy (result, input)	
	# �����  ������
	print_lstr (result)
	
	# ���������� ���������
	exit
