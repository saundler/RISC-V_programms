.include "macro-syscalls.m"
.global input_path 

.text
input_path:
    push(ra)             # Sohranit' adres vozvrata na steke.
    push(s1)             # Sohranit' registr s1 (vremennaya pamyat').
    push(s2)             # Sohranit' registr s2 (vremennaya pamyat').
    push(s3)             # Sohranit' registr s3 (vremennaya pamyat').
    mv   s1, a1          # Peremestit' adres imeni fayla v s1.
    mv   s2, a2          # Peremestit' razmer imeni v s2.
    mv   s3, a3          # Peremestit' adres soobshcheniya v s3.
    mv   a0, s3          # Ustanovit' a0 na adres stroki soobshcheniya.
    mv   a1, s1          # Ustanovit' a1 na adres bufera imeni fayla.
    li   a2, 256         # Ustanovit' a2 na maksimal'nuyu dlinu dlya vvoda (256 bayt).
    li   a7, 54          # Ustanovit' a7 na nomer sistemnogo vyzova dlya sethostname (kak primer).
    ecall                # Sdelat' sistemnyy vyzov.
    str_get(s1)          # Prochitat' imya fayla s konsoli v bufer po adresu s1.
    pop(s3)              # Vosstanovit' registr s3.
    pop(s2)              # Vosstanovit' registr s2.
    pop(s1)              # Vosstanovit' registr s1.
    pop(ra)              # Vosstanovit' adres vozvrata.  
    ret                  # Vernut'sya iz funktsii.
