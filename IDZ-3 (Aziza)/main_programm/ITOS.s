.include "macro-syscalls.m"
.include "programms-macros.m"
.global ITOS

.data
nums:   .asciz "0123456789"  # Opredelit' stroku tsifr dlya preobrazovaniya v ASCII

.text
ITOS:
    push(ra)                  # Sohranit' adres vozvrata
    push(s0)                  # Sohranit' registr s0
    push(s1)                  # Sohranit' registr s1
    push(s2)                  # Sohranit' registr s2
    mv  s0 a0                 # Peremestit' chislo dlya preobrazovaniya v s0
    mv  s1 a1                 # Peremestit' adres bufera v s1
    li  s2 0                  # Initsializirovat' s2 kak 0 (schetchik kolichestva tsifr)
    beqz   s0 if_zero         # Esli chislo nol', obrabotat' otdel'no
    la    t2 nums             # Zagruzit' adres stroki tsifr
    mv    t3 s1               # Sohranit' nachal'nyy adres bufera v t3
while:
    li    t1 10               # Ustanovit' znachenie 10 v t1
    rem   t4 s0 t1            # Poluchit' ostatok (t4 = s0 % 10)
    div   s0 s0 t1            # Razdelit' chislo na 10 (s0 = s0 / 10)
    add   t4 t4 t2            # Dobavit' k t4 t2
    lb    t4 (t4)             # Zagruzit' simvol ASCII tsifry
    sb    t4 (s1)             # Sohranit' simvol v bufer
    addi  s1 s1 1             # Pereyti k sleduyushchemu polozheniyu v bufer
    addi  s2 s2 1             # Uvelichit' schetchik tsifr
    bnez  s0 while            # Esli s0 ne nol', prodolzhit' tsikl
    sb    zero (s1)           # Zapisat' nol' po adresu s1
    rev_str(t3)               # Vyzvat' funktsiyu dlya razvorota stroki
    mv    a0 s2               # Peremestit' schetchik tsifr v a0
    pop(s2)                   # Vosstanovit' s2 so steka
    pop(s1)                   # Vosstanovit' s1 so steka
    pop(s0)                   # Vosstanovit' s0 so steka
    pop(ra)                   # Vosstanovit' adres vozvrata so steka
    ret                        # Vernut'sya iz funktsii

if_zero:
    li    t0 48               # ASCII znachenie dlya '0'
    sb    t0 (s1)             # Zapisat' '0' v bufer
    addi  s1 s1 1             # Uvelichit' ukazatel' bufera
    sb    zero (s1)           # Dobavit' nulevoy terminator
    li    a0 1                # Ustanovit' schetchik tsifr v 1
    pop(s2)                   # Vosstanovit' s2 so steka
    pop(s1)                   # Vosstanovit' s1 so steka
    pop(s0)                   # Vosstanovit' s0 so steka
    pop(ra)                   # Vosstanovit' adres vozvrata so steka
    ret                        # Vernut'sya iz funktsii
