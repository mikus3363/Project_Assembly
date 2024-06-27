.text
.global potega_modulo

potega_modulo:

    pushq %rbp              # Zapisz poprzednią wartość rbp na stosie
    movq %rsp, %rbp         # Ustaw rbp na aktualną wartość stosu

    movq %rdi, %rax         # Pierwszy argument (liczba A) w rejestrze rdi idzie do rejestru rax 
    movq %rsi, %rbx         # Drugi argument (liczba B) w rejestrze rsi idzie do rejestru rbx
    movq %rdx, %rcx         # Trzeci argument (liczba C) w rejestrze rdx idzie do rejestru rcx 

    # Initial modulo operation to get A mod C
    cqto                    # Rozszerzenie znaku do RDX:RAX
    divq %rcx               # Dzielenie A przez C
    movq %rdx, %rdi         # Resztę (A mod C) zapisujemy do rdi

    # Ustawienie początkowej wartości wyniku na 1
    movq $1, %rax           # Ustaw wynik na 1

pot_loop:
    testq %rbx, %rbx        # Sprawdzenie, czy B jest 0
    jz end_pot_loop         # Jeśli B == 0, zakończ pętlę

    # Mnożenie wyniku przez (A mod C)
    mulq %rdi               # Wynik *= (A mod C)
    movq %rax, %xmm0        # Przeniesienie młodszych bitów wyniku do xmm0
    movq %rdx, %xmm1        # Przeniesienie starszych bitów wyniku do xmm1
    punpcklqdq %xmm1, %xmm0 # Sklejenie obydwu części do jednej 128-bitowej liczby w xmm0

    movq %xmm0, %rax        # Przeniesienie młodszych bitów liczby 128-bitowej do rax
    movq %xmm1, %rdx        # Przeniesienie starszych bitów liczby 128-bitowej do rdx
    cqto                    # Rozszerzenie znaku do RDX:RAX
    divq %rcx               # Dzielenie przez C
    movq %rdx, %rax         # Resztę (wynik mod C) zapisujemy do rax

    # Decrementowanie B
    decq %rbx               # B--

    jmp pot_loop            # Powrót do początku pętli

end_pot_loop:
    movq %rax, %rdi         # Zapisujemy wynik do rejestru rdi, który zwróci funkcja

    popq %rbp               # Przywróć poprzednią wartość rbp
    ret 
