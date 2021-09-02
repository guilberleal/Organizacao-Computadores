#include <stdio.h>
#include <stdlib.h>

int m,p,n,i,j,aux;

int main(int argc, char *argv[]) {
	
	printf("Digite o numero de linhas da Matriz 1: ");
	scanf("%d",&n);
	printf("Digite o numero de colunas da Matriz 1: ");
	scanf("%d",&p);
	printf("Digite o numero de colunas para Matriz 2: ");
	scanf("%d",&m);
	printf("O numero de linhas da Matriz 2 sera o numero de colunas da Matriz 1: N = %d\n", p);
	printf("A terceira Matriz sera nxm[%d][%d]\n",n,m);
	getchar();
	getchar();
	system("cls");
	int **np = (int**)malloc(sizeof(int*)*n);
	i = 0 ;
	while(i < n){
		np[i] = (int*)malloc(sizeof(int)*p);
		i++;
	}
	
	int **pm = (int**)malloc(sizeof(int*)*p);
	i = 0 ;
	while(i < p){
		pm[i] = (int*)malloc(sizeof(int)*m);
		i++;
	}
	
	i = 0;
	j = 0;
	printf("Preenchendo a Matriz 1 nxp[%d][%d]\n",n,p);
	while(i < n){
		while(j < p){
			scanf("%d",&np[i][j]);
			j++;
		}
		j = 0;
		i++;
	}
	i = 0;
	j = 0;
	printf("Preenchendo a Matriz 2 pxm[%d][%d]\n",p,m);
	while(i < p){
		while(j < m){
			scanf("%d",&pm[i][j]);
			j++;
		}
		j = 0;
		i++;
	}
	system("cls");
	printf("A Matriz 1 eh\n");
	i = 0;
	j = 0;
	while(i < n){
		while(j < p){
			printf("[%d]",np[i][j]);
			j++;
		}
		printf("\n");
		j = 0;
		i++;
	}
	printf("\nA Matriz 2 eh\n");
	i = 0;
	j = 0;
	while(i < p){
		while(j < m){
			printf("[%d]",pm[i][j]);
			j++;
		}
		printf("\n");
		j = 0;
		i++;
	}
	getchar();
	getchar();
	int nm[n][m];
	i = 0;
	j = 0;
	aux = 0;
	while(i < n){
		while(j < m){
			nm[i][j] = 0;
			while(aux < p){
				nm[i][j]+= np[i][aux]*pm[aux][j];
				aux++;
			}
			aux = 0;
			j++;
		}
		j = 0;
		i++;
	}
	i = 0;
	j = 0;
	printf("O resultado do produto da Matriz 1 com a Matriz 2 eh\n");
	while(i < n){
		while(j < m){
			printf("[%d]",nm[i][j]);
			j++;
		}
		printf("\n");
		j = 0;
		i++;
	}
	
	return 0;
}
