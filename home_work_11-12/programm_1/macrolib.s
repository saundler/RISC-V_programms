# ������������ ������
.macro strcpy (%x, %y)
	la	a1 %x
	la	a0 %y
	jal	strcpy
.end_macro

# ����� ����������� �����
.macro print_int (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

# ������ ����������� �����
.macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
.end_macro

# ����� ������
.macro print_lstr (%x)
	la 	a0 %x
	li	a7 4
	ecall
.end_macro

# ����� ������
.macro print_str (%x)
.data
str:	.asciz %x
   .text
   push (a0)
   li a7, 4
   la a0, str
   ecall
   pop	(a0)
.end_macro

# ����� �����
.macro print_char(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

# ������� �� ����� ������
.macro newline
   print_char('\n')
.end_macro

# ����� ������ �����������
.macro sep
   print_str ("----------\n")
.end_macro

# ���������� ���������
.macro exit
    li a7, 10
    ecall
.end_macro

# ���������� ��������� �������� �� �����
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

# ������������ �������� � ������� ����� � �������
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro
