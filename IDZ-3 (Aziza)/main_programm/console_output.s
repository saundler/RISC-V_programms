.include "macro-syscalls.m"
.global console_output 

.text
console_output:
    mv   t5 a0                # Peremestit' dannye iz a0 v t5
    # Pechat' stroki
    print_str("Dlya vyvoda otveta nazhmite Y ili N, esli vy ne khotite: ")
    li t1 78                  # Ustanovit' znachenie 78 v t1
    li t2 110                 # Ustanovit' znachenie 110 v t2
    li t3 89                  # Ustanovit' znachenie 89 v t3
    li t4 121                 # Ustanovit' znachenie 121 v t4
while:
    li a7 12                  # Sistemnyy vyzov dlya chteniya simvola
    ecall
    mv t0 a0                  # Peremestit' prochitannyy simvol v t0
if_n:
    beq t0 t1 continue        # Proverka na 'N'
    beq t0 t2 continue        # Proverka na 'n'    
if_y:
    beq t0 t3 end_while       # Proverka na 'Y'
    beq t0 t4 end_while       # Proverka na 'y'
    # Pechat' stroki
    print_str("\nneizvestnaya komanda, povtorite vvod: ")
    j while
end_while:
    newline
    li a7  4                  # Sistemnyy vyzov dlya vyvoda stroki v konsol'
    mv a0 t5                  # Adres bufera stroki
    ecall                     
continue:
    ret                       # Vernut'sya iz funktsii
