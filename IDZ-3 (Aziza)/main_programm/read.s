.include "macro-syscalls.m"
.global read 

.text
read:
    push(ra)             		# Sohranit' adres vozvrata
    push(s0)             		# Sohranit' registr s0
    push(s1)             		# Sohranit' registr s1
    push(s2)             		# Sohranit' registr s2
    push(s4)			 		# Sohranit' registr s4
    mv   s1 a1          		# Peremestit' imya fayla v s1
    mv   s2 a2          		# Peremestit' razmer teksta v s2
    open(s1, READ_ONLY)			# Otkryt' fayl tol'ko dlya chteniya
    li   t0, -1          		# Proverka na uspeshnoe otkrytie fayla
    beq  a0, t0, er_name 		# Obrabotka oshibki otkrytiya fayla
    mv   s0, a0          		# Sohranit' deskriptor fayla
    allocate(s2)         		# Vydelenie bloka pamyati razmerom s2
    mv   s3, a0          		# Sohranit' adres heap v s3
    mv   t1, a0          		# Sohranit' modifitsiruyemyy adres heap v t1
    mv   s4, zero        		# Initsializirovat' dlinu prochitannogo teksta kak 0

while:
    read_addr_reg(s0, t1, s2) 	# Chitat' v adres bloka iz registra
    beq  a0, t0, er_read 		# Esli oshibka chteniya, pereyti k obrabotke oshibki
    add  s4, s4, a0      		# Uvelichit' razmer teksta na prochitannuyu chast'
    bne  a0, s2, end_while 		# Esli dlinna prochitannogo teksta men'she razmera bufera, zavershit' protsess
    allocate(s2)         		# Vydelenie eshche pamyati
    add  t1, t1, s2      		# Perevesti adres chteniya vpered na razmer prochitannoy chasti
    j    while       			# Prodolzhit' chtenie sleduyushchey chasti teksta
end_while:
    close(s0)					# Zakryt' fayl
    add  t0 s3 s4      			# Adres poslednego prochitannogo simvola
    addi t0 t0 1       			# Pozitsiya dlya nulevogo terminatora
    sb   zero (t0)      		# Zapisat' nulevoy terminator v konce teksta
    mv   a0 s0          		# Deskriptor fayla
    mv   a1 s3          		# Nachalo bufera
    pop(s4)
    pop(s3)
    pop(s1)
    pop(s0)
    pop(ra)
    ret

er_name:
    # Pechat' stroki
    print_str ("Nevernoye imya fayla!!!")
    exit

er_read:
    # Pechat' stroki
    print_str ("Nepravil'naya operatsiya chteniya!!!")
    exit
