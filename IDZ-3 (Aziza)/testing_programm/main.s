.include "macro-syscalls.m"
.include "programms-macros.m"
.global main

.eqv    TEXT_SIZE 512	

.data
test.1:    .asciz "../test/test.1.txt"  # Put' k testovomu faylu 1
res.1:     .asciz "../test/res.1.txt"   # Put' k faylu rezul'tata 1
test.2:    .asciz "../test/test.2.txt"  # Put' k testovomu faylu 2
res.2:     .asciz "../test/res.2.txt"   # Put' k faylu rezul'tata 2
test.3:    .asciz "../test/test.3.txt"  # Put' k testovomu faylu 3
res.3:     .asciz "../test/res.3.txt"   # Put' k faylu rezul'tata 3
desc:      .word 0                      # Deskriptor fayla
buff:      .word 0                      # Bufer dlya soderzhimogo fayla
ans.len:   .word 0                      # Dlina otveta
ans:       .word 0                      # Bufer dlya otveta
.text
main:    
    # Chitaet soderzhimoe pervogo testovogo fayla v bufer
    read(test.1, TEXT_SIZE)  
    # Sohranyaet deskriptor fayla i adres bufera
    la  t0 desc    
    sw  a0 (t0)    
    la  t0 buff    
    sw  a1 (t0)    
    # Obrabatyvaet soderzhimoe bufera
    replace(buff, ans, ans.len)
    # Zapisyvaet rezul'tat v pervyy fayl rezul'tatov
    write(res.1, ans, ans.len)

    # Povtoryaet operatsii dlya vtorogo testovogo fayla
    read(test.2, TEXT_SIZE)  
    la  t0 desc    
    sw  a0 (t0)    
    la  t0 buff    
    sw  a1 (t0)    
    replace(buff, ans, ans.len)
    write(res.2, ans, ans.len)

    # Povtoryaet operatsii dlya tretego testovogo fayla
    read(test.3, TEXT_SIZE)  
    la  t0 desc    
    sw  a0 (t0)    
    la  t0 buff    
    sw  a1 (t0)    
    replace(buff, ans, ans.len)
    write(res.3, ans, ans.len)

    # Zavershaet programmu
    exit
