# =================================================================================
# Makrobiblioteka dlya sistemnykh vyzovov
# =================================================================================

# ----------------------------------------------------------------------------------
# Pechat' soderzhimogo ukazannogo registra kak tselogo chisla
# %x - Registr, soderzhashchiy tseloe chislo dlya pechati
.macro print_int (%x)
    li a7, 1          # Ustanovit' nomer sistemnogo vyzova dlya pechati tselogo chisla
    mv a0, %x         # Peremestit' tseloe chislo iz registra %x v a0
    ecall             # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Pechat' neposredstvenno zadannogo tselogo chisla
# %x - Neposredstvenno zadannoe tseloe chislo dlya pechati
.macro print_imm_int (%x)
    li a7, 1          # Ustanovit' nomer sistemnogo vyzova dlya pechati tselogo chisla
    li a0, %x         # Zagruzit' neposredstvenno zadannoe tseloe chislo v a0
    ecall             # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Pechat' stroki, zakanchivayushcheysya nulem
# %x - Stroka dlya pechati
.macro print_str (%x)
    .data
    str: .asciz %x    # Opredelit' stroku v razdele dannykh
    .text
    push (a0)         # Sohranit' a0 na steke
    li a7, 4          # Ustanovit' nomer sistemnogo vyzova dlya pechati stroki
    la a0, str        # Zagruzit' adres stroki v a0
    ecall             # Vypolnit' sistemnyy vyzov
    pop (a0)          # Vosstanovit' a0 so steka
.end_macro

# ----------------------------------------------------------------------------------
# Pechat' odnogo ukazannogo simvola
# %x - Simvol dlya pechati
.macro print_char(%x)
    li a7, 11         # Ustanovit' nomer sistemnogo vyzova dlya pechati simvola
    li a0, %x         # Zagruzit' simvol v a0
    ecall             # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Pechat' simvola novoy stroki
.macro newline
    print_char('\n')  # Pechat' simvola novoy stroki
.end_macro

# ----------------------------------------------------------------------------------
# Chtenie tselogo chisla s konsoli v registr a0
.macro read_int_a0
    li a7, 5          # Ustanovit' nomer sistemnogo vyzova dlya chteniya tselogo chisla
    ecall             # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Chtenie tselogo chisla s konsoli v ukazannyy registr, isklyuchaya a0
# %x - Registr dlya sohraneniya prochitannogo tselogo chisla
.macro read_int(%x)
    push (a0)         # Sohranit' a0 na steke
    li a7, 5          # Ustanovit' nomer sistemnogo vyzova dlya chteniya tselogo chisla
    ecall             # Vypolnit' sistemnyy vyzov
    mv %x, a0         # Peremestit' prochitannoe tseloe chislo iz a0 v %x
    pop (a0)          # Vosstanovit' a0 so steka
.end_macro

# ----------------------------------------------------------------------------------
# Chtenie stroki v bufer s ukazannym razmerom, zamena simvola novoy stroki na nul'
# %strbuf - Adres bufera
.macro str_get(%strbuf)
    push(s3)
    push(s1)
    push(s2)
    li  s3 '\n'         # Ustanovit' simvol novoy stroki dlya sravneniya
    mv  s1  %strbuf     # Ustanovit' nachal'nyy adres bufera
next:
    lb  s2  (s1)        # Zagruzit' bayt iz bufera
    beq s3  s2  replace  # Esli novaya stroka, zamenit' na nul'
    addi s1 s1 1        # Uvelichit' adres bufera
    b   next
replace:
    sb  zero (s1)       # Zamenit' novuyu stroku na nul'
    pop(s2)
    pop(s1)
    pop(s3)
.end_macro

# ----------------------------------------------------------------------------------
# Otkryt' fayl dlya chteniya, zapisi ili dobavleniya
.eqv READ_ONLY	0	# Otkryt' dlya chteniya
.eqv WRITE_ONLY	1	# Otkryt' dlya zapisi
.eqv APPEND	    9	# Otkryt' dlya dobavleniya
# %file_name - Imya fayla dlya otkrytiya
# %opt       - Flag vybora (0 dlya chteniya, 1 dlya zapisi, 9 dlya dobavleniya)
.macro open(%file_name, %opt)
	mv    a0 %file_name # Ustanovit' imya fayla dlya otkrytiya
    li    a1 %opt       # Ustanovit' flag vybora dlya otkrytiya fayla
    li    a7 1024       # Ustanovit' nomer sistemnogo vyzova dlya otkrytiya fayla
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Chtenie informatsii iz otkrytogo fayla
# %file_descriptor - Deskriptor otkrytogo fayla
# %strbuf          - Adres bufera dlya prochitannogo teksta
# %size            - Razmer chitayemoy chasti
.macro read(%file_descriptor, %strbuf, %size)
    li   a7, 63         # Ustanovit' nomer sistemnogo vyzova dlya chteniya iz fayla
    mv   a0, %file_descriptor  # Ustanovit' deskriptor fayla dlya chteniya
    la   a1, %strbuf    # Ustanovit' adres bufera dlya chteniya
    li   a2, %size      # Ustanovit' razmer chitayemoy chasti
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Chtenie informatsii iz otkrytogo fayla, adres bufera v registre
# %file_descriptor - Deskriptor otkrytogo fayla
# %reg             - Registr, soderzhashchiy adres bufera
# %size            - Razmer chitayemoy chasti
.macro read_addr_reg(%file_descriptor, %reg, %size)
    li   a7, 63         # Ustanovit' nomer sistemnogo vyzova dlya chteniya iz fayla
    mv   a0, %file_descriptor  # Ustanovit' deskriptor fayla dlya chteniya
    mv   a1, %reg       # Ustanovit' adres bufera iz registra dlya chteniya
    mv   a2, %size      # Ustanovit' razmer chitayemoy chasti
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Zakryt' otkrytyy fayl
# %file_descriptor - Deskriptor fayla dlya zakrytiya
.macro close(%file_descriptor)
    li   a7, 57         # Ustanovit' nomer sistemnogo vyzova dlya zakrytiya fayla
    mv   a0, %file_descriptor  # Ustanovit' deskriptor fayla dlya zakrytiya
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Vydelenie dinamicheskoy pamyatnoy oblasti ukazannogo razmera
# %size - Razmer bloka pamyati dlya vydeleniya
.macro allocate(%size)
    li a7, 9            # Ustanovit' nomer sistemnogo vyzova dlya vydeleniya pamyati
    mv a0, %size        # Ustanovit' razmer bloka pamyati dlya vydeleniya
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Zavershenie programmy
.macro exit
    li a7, 10           # Ustanovit' nomer sistemnogo vyzova dlya zaversheniya programmy
    ecall               # Vypolnit' sistemnyy vyzov
.end_macro

# ----------------------------------------------------------------------------------
# Sohranenie ukazannogo registra na steke
# %x - Registr dlya sohraneniya
.macro push(%x)
    addi sp, sp, -4     # Umen'shit' ukazatel' steka
    sw   %x, (sp)       # Sohranit' registr %x na steke
.end_macro

# ----------------------------------------------------------------------------------
# Izvlechenie znacheniya s verkhushki steka v registr
# %x - Registr dlya zagruzki
.macro pop(%x)
    lw  %x, (sp)        # Zagruzit' znachenie so steka v registr %x
    addi sp, sp, 4      # Uvelichit' ukazatel' steka
.end_macro
