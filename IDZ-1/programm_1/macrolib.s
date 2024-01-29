# Vyvod desyatichnogo chisla
.macro print_int (%x)
	li a7 1							# 1 systemnyi vyzov - vyvod desyatichnogo chisla
	mv a0 %x						# Peremestim znachenye %x v registr a0
	ecall
.end_macro

# Chteniye desyatichnogo chisla
.macro read_int(%x)
   li a7 5							# 5 systemnyi vyzov - chtenye desyatichnogo chisla
   ecall
   mv %x, a0						# Peremestim znachenye a0 v %x
.end_macro


# Vyvod stroki
.macro print_str (%x)
.data
str:	.asciz %x					# Stroka vyvoda
   .text
   push (a0)						# Sohranenye znachenya registra a0 v pamyat
   li a7 4							# 4 systemnyi vyzov - vyvod stroky
   la a0 str						# Zagruzim adress stroky v registr a0
   ecall
   pop	(a0)						# Vozvrat k pregdnemu chislu
.end_macro

# Vyvod znaka
.macro print_char(%x)
   li a7 11							# 11 systemnyi vyzov - vyvod symvola	
   li a0 %x							# Prisvoim registru a0 symvol %x
   ecall
.end_macro

# Perekhod na novuyu stroku
.macro newline
   print_char('\n')					# Vyvod symvola '\n'
.end_macro

# Vyvod stroki razdelitelya
.macro sep
   print_str ("----------\n")		# Vyvod stroky "----------\n"
.end_macro

# Zaversheniye programmy
.macro exit
    li a7, 10						# 10 systemnyi vyzov - zavershenye programmy	
    ecall
.end_macro

# Sokhraneniye zadannogo registra na steke
.macro push(%x)
	addi	sp, sp, -4				# Umen'shenye registra sp na 4
	sw	%x, (sp)					# Sohranenye %x по адресу sp
.end_macro

# Vytalkivaniye znacheniya s vershiny steka v registr
.macro pop(%x)
	lw	%x, (sp)					# Zapis znachenya po adresu sp v %x
	addi	sp, sp, 4				# Uvelychenye registra sp na 4
.end_macro
