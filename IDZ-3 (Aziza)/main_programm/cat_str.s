.include "macro-syscalls.m"
.global cat_str

.text
cat_str:
    push(ra)                 # Sohranit' adres vozvrata
    push(s0)                 # Sohranit' registr s0
    push(s1)                 # Sohranit' registr s1
    mv    s0 a0              # Peremestit' adres pervoy stroki v s0
    mv    s1 a1              # Peremestit' adres vtoroy stroki v s1
while_a1:
    lb    t1 (s1)            # Zagruzit' bayt po adresu v s1
    beqz  t1 end             # Esli eto nulevoy terminator, zavershit' kopirovanie
    sb    t1 (s0)            # Sohranit' bayt iz s1 v konec s0
    addi  s0 s0 1            # Uvelichit' s0, chtoby pereyti k sleduyushchemu baytu
    addi  s1 s1 1            # Uvelichit' s1, chtoby pereyti k sleduyushchemu baytu
    j while_a1               # Prygnut' nazad, chtoby prodolzhit' kopirovanie
end:
    pop(s1)                  # Vosstanovit' s1 so steka
    pop(s0)                  # Vosstanovit' s0 so steka
    pop(ra)                  # Vosstanovit' adres vozvrata so steka
    ret                      # Vernut'sya iz funktsii
