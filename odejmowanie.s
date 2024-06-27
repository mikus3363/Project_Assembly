.text
.global odej_modulo

odej_modulo:
    pushq %rbp          # Zapisz poprzednia wartosc rbp na stosie
    movq %rsp, %rbp     # Ustaw rbp na aktualna wartosc stosu

    movq %rdi, %rax     # Pierwszy argument (liczba A) do rejestru rax
    movq %rsi, %rbx     # Drugi argument (liczba B) do rejestru rbx
    movq %rdx, %rcx     # Trzeci argument (modulo C) do rejestru rcx

    cqto                # Rozszerzenie potrzebne do dzielenia liczb 64-bitowych
    divq %rcx           # Dzielenie A przez C
    movq %rdx, %rdi     # Reszta z dzielenia (A % C) zapisujemy w rdi

    movq %rbx, %rax     # Druga liczba B do rejestru rax
    cqto                # Rozszerzenie potrzebne do dzielenia liczb 64-bitowych
    divq %rcx           # Dzielenie B przez C
    movq %rdx, %rbx     # Reszta z dzielenia (B % C) zapisujemy w rbx

    movq %rdi, %rax     # Zapisujemy resztę z dzielenia (A % C) do rejestru rax
    subq %rbx, %rax     # Wykonujemy odejmowanie (A % C) - (B % C)

    # Dodajemy modulo, aby wynik był zawsze dodatni
    addq %rcx, %rax     # Dodajemy modulo C, aby wynik był dodatni
    cqto                # Rozszerzenie potrzebne do dzielenia liczb 64-bitowych
    divq %rcx           # Dzielenie przez C
    movq %rdx, %rax     # Reszta z dzielenia (wynik ostateczny) do rejestru rax

    popq %rbp           # Przywroc poprzednia wartosc rbp
    ret                 # Zakonczenie funkcji i zwrocenie wartosci w rax
