# Chitaet soderzhimoe fayla v dinamicheski vydelenyy bufer
.macro read(%desc, %TEXT_SIZE)
    la a1 %desc           # Adres deskriptora fayla
    li a2 %TEXT_SIZE      # Razmer bufera dlya chteniya
    jal read              # Vyzvat' funktsiyu read_file
.end_macro

# Schitaet kolichestvo zaglavnukh i malen'kikh bukv v stroke
.macro replace(%buff, %ans, %ans_len)
    lw a0 %buff           # Adres bufera stroki
    la a1 %ans            # Adres bufera otveta
    la a2 %ans_len        # Adres peremennoy dlya hraneniya dlina otveta
    jal replace           # Vyzvat' funktsiyu replace
.end_macro

# Obrashchaet nulevoy terminirovannuyu stroku na meste
.macro rev_str(%buff)
    mv a0 %buff           # Adres bufera stroki
    jal rev_str           # Vyzvat' funktsiyu str_reverse
.end_macro

# Preobrazuet tseloe chislo v stroku
.macro ITOS(%num, %cnt_buffer)
    mv a0 %num            # Tseloe chislo dlya preobrazovaniya
    la a1 %cnt_buffer     # Adres vykhodnogo bufera
    jal ITOS              # Vyzvat' funktsiyu int_to_string
.end_macro

# Konkateniruet dve stroki
.macro cat_str(%str, %buff)
    mv a0 %str            # Adres pervoy stroki
    la a1 %buff           # Adres vtoroy stroki
    jal cat_str           # Vyzvat' funktsiyu strcat
.end_macro

# Zapisyvaet oformlennoe soderzhimoe v fayl
.macro write(%desc, %ans, %ans_len)
    la a0 %desc           # Adres deskriptora fayla
    lw a1 %ans            # Zagruzit' adres rezul'tiruyushchey stroki v a1
    lw a2 %ans_len        # Zagruzit' dlina rezul'tiruyushchey stroki v a2
    jal write             # Vyzvat' funktsiyu write_file
.end_macro

# Predlagaet pol'zovatelyu vvesti imya fayla i sohranyaet ego v bufer
.macro input_path(%file, %NAME_SIZE, %str)
.data 
 message:   .asciz %str   # Soobshchenie dlya vvoda
.text
    la a1 %file           # Adres bufera dlya imeni fayla
    li a2 %NAME_SIZE      # Razmer bufera dlya imeni fayla
    la a3 message         # Adres soobshcheniya dlya vvoda
    jal input_path        # Vyzvat' podprogrammu input_filename
.end_macro

# Predostavlyaet vybor dlya vyvoda rezul'tiruyushchey stroki v konsol' ili net
.macro console_output(%str)
    lw a0, %str           # Zagruzit' adres rezul'tiruyushchey stroki
    jal console_output    # Prygnut' k funktsii write_file
.end_macro
