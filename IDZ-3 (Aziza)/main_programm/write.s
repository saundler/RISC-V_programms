.include "macro-syscalls.m"
.global write 

.text
write:
    push(s0)                    # Sohranit' registr s0
    push(s1)                    # Sohranit' registr s1
    push(s2)                    # Sohranit' registr s2
    push(s3)                    # Sohranit' registr s3
    mv s0 a0                    # Peremestit' deskriptor fayla v s0
    mv s1 a1                    # Peremestit' adres otveta v s1
    mv s2 a2                    # Peremestit' dlina otveta v s2
    open(s0, WRITE_ONLY)        # Otkryt' fayl tol'ko dlya zapisi
    li   t0, -1                 # Proverka na uspeshnoe otkrytie fayla
    beq  a0, t0, er_name        # Obrabotka oshibki otkrytiya fayla
    mv   s0, a0                 # Sohranit' deskriptor fayla
    li a7 64                    # Sistemnyy vyzov dlya zapisi v fayl
    mv a0 s0                    # Deskriptor fayla
    mv a1 s1                    # Adres bufera teksta
    mv a2 s2                    # Ustanovit' znachenie s2 v a2
    ecall                       # Zapis' v fayl
    pop(s3)                     # Vosstanovit' s3
    pop(s2)                     # Vosstanovit' s2
    pop(s1)                     # Vosstanovit' s1
    pop(s0)                     # Vosstanovit' s0
    ret                         # Vernut'sya iz funktsii

# Obrabotka oshibki dlya nevernogo imeni fayla
er_name:
    # Pechat' stroki
    print_str("Nevernoye imya fayla!!!")
    exit  
