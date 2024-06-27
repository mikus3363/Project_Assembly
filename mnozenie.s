
.text
.global mnoz_modulo

mnoz_modulo:

pushq %rbp          #Zapisz poprzednia wartosc rbp na stosie
movq %rsp, %rbp     #Ustaw rbp na aktualna wartosc stosu

movq %rdi, %rax     #pierwszy argument (liczba A) po wywolaniu z rejestru rdi idzie do rejestru rax 

movq %rsi, %rbx     #drugi argument (liczba B) po wywolaniu z rejestru rsi idzie do rejestru rbx 
 
movq %rdx, %rcx     #trzeci argument (liczba C) po wywolaniu z rejestru rdi idzie do rejestru rcx 
cqto                #rozszerzenie potrzebne do dzielenia liczb 64 bitowych

divq %rcx           #dzielenie pierwszej liczby A w rax przez modulo C 
movq %rdx, %rdi	    #reszte z dzielenia (AmodC) zapisujemy w rejestrze rdi  

movq %rbx, %rax     #druga liczba B zapisujemy do rejestru rax by wykonywac operacje  

cqto                #rozszerzenie potrzebne do dzielenia liczb 64 bitowych      

divq %rcx           #dzielenie drugiej liczby B w rax przez modulo C     
movq %rdx, %rbx	    #reszte z dzielenia (BmodC) zapisujemy w rejestrze rbx   

movq %rdi, %rax	    #zapisujemy resztę z dzielenia (AmodC) do rejestru rax   

mulq %rbx	    #wykonujemy mnożenie rax*rbx (AmodC*BmodC)

movq %rax, %xmm0    #przenosimy mlodsze bity wyniku do rejestru 128 bitowego xmm0
movq %rdx, %xmm1    #przenosimy starsze bity wyniku do rejestru 128 bitowego xmm1
punpcklqdq %xmm1, %xmm0 #sklejamy obydwie liczby 128 bitowe tworząc jedną liczbę 128 bitową w xmm0

movq %xmm0, %rax    #przenosimy młodsze bity liczby 128 bitowej do rejestru 64 bitowego
movq %xmm1, %rdx    #przenosimy starsze bity liczby 128 bitowej do rejestru 64 bitowego

divq %rcx	    #wykonujemy dzielenie z resztą (AmodC*BmodC)modC

movq %rdx, %rax	    #reszte zapisujemy do rejestru rax ktory bedziemy zwracac (wynik wyzszego dzialania) 
	       
popq %rbp           #Przywroc poprzednia wartosc rbp
ret		    #Zakonczenie funkcji i zwrocenie wartosci w rax




