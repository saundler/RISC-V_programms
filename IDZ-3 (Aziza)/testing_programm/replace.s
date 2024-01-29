.include "macro-syscalls.m"
.include "programms-macros.m"
.global replace 

.eqv    NAME_SIZE 256

.data 
number: 	.space 4     # Rezerviruyem mesto dlya predstavleniya chisla kak stroki

.text
replace:
    push(ra)             # Sohranit' adres vozvrata
    push(s0)             # Sohranit' registr s0
    push(s1)             # Sohranit' registr s1
    push(s2)             # Sohranit' registr s2
    push(s3)             # Sohranit' registr s3
    push(s4)             # Sohranit' registr s4
    mv    s0 a0          # Peremestit' bufer iskhodnoy stroki v s0
    mv    s3 a1          # Peremestit' bufer otveta v s3
    mv    s4 a2          # Peremestit' dlina otveta v s4
    li    t0 1           # Ustanovit' znachenie 1 v t0 (dlina bloka dlya vydeleniya)
    allocate(t0)         # Vydelenie bloka pamyati dlina 1
    mv    s1 a0          # Peremestit' a0 v s1 (tekushchaya pozitsiya v bufer)
    sw    s1 (s3)        # Zapisat' adres tekushchey pozitsii v bufer otveta
    li    s2 0           # Initsializirovat' schetchik prochitannykh simvolov v 0
while:
    lb    t0 (s0)        # Zagruzit' tekushchiy simvol iz bufera
    beqz  t0 end_while   # Esli simvol yavlyaetsya nulevym terminatorom, zavershit' tsikl
    addi  s0 s0 1        # Uvelichit' ukazatel' na bufer
    # Nachalo obrabotki kazhdogo simvola
big_consonant:
    li    t1 66          # Ustanovit' ASCII kod dlya 'B'
    blt   t0 t1 end_if   # Proverit', menshe li tekushchiy simvol, chem 'B'
    li    t1 90          # Ustanovit' ASCII kod dlya 'Z'
    bgt   t0 t1 small_consonant # Proverit', bolshe li simvol, chem 'Z'
    # Proverka na zaglavnye soglasnye, krome opredelennykh glasnykh
    li    t1 69          # ASCII kod dlya 'E'
    beq   t0 t1 end_if
    li    t1 73          # ASCII kod dlya 'I'
    beq   t0 t1 end_if
    li    t1 79          # ASCII kod dlya 'O'
    beq   t0 t1 end_if
    li    t1 85          # ASCII kod dlya 'U'
    beq   t0 t1 end_if
    li    t1 89          # ASCII kod dlya 'Y'
    beq   t0 t1 end_if
    j     continue
small_consonant:
    li    t1 98          # Ustanovit' ASCII kod dlya 'b'
    blt   t0 t1 end_if   # Proverit', menshe li simvol, chem 'b'
    li    t1 122         # Ustanovit' ASCII kod dlya 'z'
    bgt   t0 t1 end_if   # Proverit', bolshe li simvol, chem 'z'
    # Proverka na malen'kie soglasnye, krome opredelennykh glasnykh
    li    t1 101         # ASCII kod dlya 'e'
    beq   t0 t1 end_if
    li    t1 105         # ASCII kod dlya 'i'
    beq   t0 t1 end_if
    li    t1 111         # ASCII kod dlya 'o'
    beq   t0 t1 end_if
    li    t1 117         # ASCII kod dlya 'u'
    beq   t0 t1 end_if
    li    t1 121         # ASCII kod dlya 'y'
    beq   t0 t1 end_if
    j     continue
continue:
    ITOS(t0, number)     # Preobrazovanie tekushchego simvola v stroku
    mv    t5 a0
    allocate(t5)         # Vydelenie pamyati pod stroku
    cat_str(s1, number)  # Konkatenatsiya tekushchego simvola i stroki
    add   s1 s1 t5
    add   s2 s2 t5
    j     while
end_if:
    li    t1 1
    allocate(t1)         # Vydelenie pamyati dlya 1 simvola
    sb    t0 (s1)        # Zapis' simvola v bufer
    addi  s2 s2 1
    addi  s1 s1 1
    j     while
end_while:
    addi  s1 s1 1
    sb    zero (s1)      # Zapis' nulevogo terminatora v konec stroki
    sw    s2 (s4)        # Zapis' obshchey dlina stroki v bufer dlina otveta
    pop(s4)
    pop(s3)
    pop(s2)
    pop(s1)
    pop(s0)
    pop(ra)
    ret                  # Vernut'sya iz funktsii
