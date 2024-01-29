.include "macro-syscalls.m"
.global rev_str

.text
rev_str:
    push(s0)             	# Sohranit' registr s0 na steke
    push(s1)             	# Sohranit' registr s1 na steke
    mv    s0 a0         	# Skopirovat' nachal'nyy adres stroki v s0
    mv    s1 a0         	# Initsializirovat' s1 dlya poiska kontsa stroki
find_end:
    lbu   a0 (s1)       	# Zagruzit' bayt po adresu v s1
    beqz  a0 continue    	# Esli eto nulevoy terminator, nachat' reversirovanie
    addi  s1 s1 1      		# Uvelichit' s1 dlya ukazaniya na sleduyushchiy bayt
    j     find_end       	# Tsikl nazad dlya prodolzheniya poiska kontsa stroki
continue:
    addi  s1 s1 -1     		# Umen'shit' s1, ukazyvaya na posledniy deystvitel'nyy simvol
while:
    bge   s0 s1 end_while  	# Esli s0 proshel ili dostig s1, zakonchit' reversirovanie
    lbu   a0 (s0)       	# Zagruzit' bayt po adresu v s0
    lbu   a1 (s1)       	# Zagruzit' bayt po adresu v s1
    sb    a0 (s1)       	# Zapisat' bayt iz s0 v s1
    sb    a1 (s0)       	# Zapisat' bayt iz s1 v s0
    addi  s0 s0 1      		# Uvelichit' s0 dlya perehoda k sleduyushchemu baytu
    addi  s1 s1 -1     		# Umen'shit' s1 dlya perehoda k predydushchemu baytu
    j while  		 		# Pryzhok nazad dlya prodolzheniya protsessa reversirovaniya
end_while:
    pop(s1)             	# Vosstanovit' registr s1 so steka
    pop(s0)              	# Vosstanovit' registr s0 so steka
    ret                  	# Vernut'sya iz funktsii
