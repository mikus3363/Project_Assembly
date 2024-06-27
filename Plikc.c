#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

extern long long mnoz_modulo(long long a, long long b, long long c);
extern long long dodaj_modulo(long long a, long long b, long long c);
extern long long odej_modulo(long long a, long long b, long long c);
extern long long potega_modulo(long long a, long long b, long long c);
void readLongLong(long long *value);
void choice();
void numbers();
void menu();
long long A;
long long B;
long long C;
long long result;
char input[256];
int i = 0;

void readLongLong(long long *value){
	while(1){
		if(fgets(input,sizeof(input),stdin)!=NULL){
			long long temp;
			if(sscanf(input, "%lld", &temp)!=1){
				printf("Nieprawidlowy format liczby. Sprobuj ponowanie.\n");
			}else if(temp == LLONG_MIN || temp == LLONG_MAX){
				printf("Wartosc po za zakresem. Sprobuj ponownie\n");
			}else{
				*value = temp;
				break;
			}
		}else{
			printf("Blad wczytania. Sprobuj ponownie\n");
		}
	}
}

void choice(){
	int k = 0;
	int x;
	do{
		printf("\nWybierz algorytm modularny: \n");
		printf("1.Mnożenie Modularne \n");
		printf("2.Dodawanie Modularne \n");
		printf("3.Odejmowanie Modularne \n");
		printf("4.Potęgowanie Modularne \n");
		scanf("%d",&x);
		switch(x){
			case 1:
				printf("Korzystajac z wzoru: (A*B)modC=(AmodC*BmodC)modC\n");
				getchar();
				numbers();
				result = mnoz_modulo(A,B,C);
				printf("Wynik mnozenia modularnego: %lld\n\n",result);
				menu();
				break;
			case 2:
				printf("Korzystajac z wzoru: (A+B)modC=(AmodC+BmodC)modC\n");
				getchar();
				numbers();
				result = dodaj_modulo(A,B,C);
				printf("Wynik dodawania modularnego: %lld\n\n",result);
				menu();
				break;
			case 3:
				printf("Korzystajac z wzoru: (A-B)modC=(AmodC-BmodC)modC\n");
				getchar();
				numbers();
				result = odej_modulo(A,B,C);
				printf("Wynik odejmowania modularnego: %lld\n\n",result);
				menu();
				break;
			case 4:
				printf("Korzystajac z wzoru: (A^B)modC=((AmodC)^B)modC\n");
				getchar();
				numbers();
				result = potega_modulo(A,B,C);
				printf("Wynik potegowania modularnego: %lld\n\n",result);
				menu();
				break;
			default:
				printf("Nieprawidlowa wartosc!\n");
		}
	}while(k==0);
}

void numbers(){
	printf("Podaj pierwsza liczbe A (64 bitowa)\n");	
	readLongLong(&A);
	printf("Podaj pierwsza liczbe B (64 bitowa)\n");	
	readLongLong(&B);
	printf("Podaj liczbe modulo C (64 bitowa)\n");	
	readLongLong(&C);
}

void menu(){
	int k = 0;
	int x;
	do{
		printf("\nChcesz kontynulowac?: \n");
		printf("1.Tak \n");
		printf("2.Nie \n");
		scanf("%d",&x);
		switch(x){
			case 1:
				getchar();
				choice();
				break;
			case 2:
				exit(1);
				break;
			default:
				printf("Nieprawidlowa wartosc!\n");
		}
	}while(k==0);
}

int main(){
	printf("\nOto program wykonujacy Algorytmy modularne\n");
	choice();
	return 0;
}











