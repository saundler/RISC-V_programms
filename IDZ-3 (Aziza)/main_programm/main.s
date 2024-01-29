.include "macro-syscalls.m"
.include "programms-macros.m"
.global main

.eqv    NAME_SIZE 256
.eqv    TEXT_SIZE 512

.data
file:       .space NAME_SIZE   # Bufår dlya hraneniya imeni fayla.
desc:       .word 0            # Peremennaya dlya hraneniya deskriptora fayla.
buff:       .word 0            # Bufår dlya soderzhimogo fayla.
ans.len:    .word 0            # Dlina otveta.
ans:        .word 0            # Bufår dlya otveta.

.text
main:
    # input_path: Zapra?ivaet u pol'zovatelya imya fayla i ?itaet ego v bufår 'file'.
    # Prinimaet adres bufera 'file', ego razmer (NAME_SIZE) i pustuyu stroku "".
    input_path(file, NAME_SIZE, "Vvedi put' k faylu dlya schityvaniya teksta")

    # read: ?itaet soder?imoe ukazannogo fayla v dinami?eski vydelenyj bufår.
    # Prinimaet imya fayla i razmer bufera dlya chteniya (TEXT_SIZE).
    read(file, TEXT_SIZE)
    
    # Sohranenie deskriptora fayla i adresa bufera soderzhimogo fayla.
    la  t0 desc
    sw  a0 (t0)
    la  t0 buff
    sw  a1 (t0)

    # replace: Pod??et koli?estva zaglavnyh i malen'kih bukv v bufere.
    # Prinimaet adres ishodnogo bufere (v kotorom nuzhno podschitat' kolichestvo zaglavnyh i malen'kih bukv),
    # adres bufere dlya rezultata (ans) i adres dlya khraneniya dliny rezultata (ans.len).
    replace(buff, ans, ans.len)

    # input_path: Znovu zaprashivaet u pol'zovatelya imya fayla dlya zapisi i chitaet ego v bufere 'file'.
    # Prinimaet adres bufera 'file', ego razmer (NAME_SIZE) i pustuyu stroku "".
    input_path(file, NAME_SIZE, "Vvedi put' k faylu dlya zapisi teksta")

    # write: Zapis' oformlennogo soderzhimogo v ukazannyj fajl.
    # Prinimaet imya fayla, adres bufera s dannymi i ih dlinu dlya zapisi.
    write(file, ans, ans.len)
    
    # console_output: Predlagaet pol'zovatelyu vybor vyvoda rezul'tiruyushchey stroki v konsol' ili net.
    # Prinimaet adres bufera s rezultatom (ans).
    console_output(ans)

    # Zavershenie programmy.
    exit
