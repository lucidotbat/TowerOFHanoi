#include <stdio.h>

void printTowers(int *source, int *dest, int *aux, int discs);
void moveDisc(int *source, int *dest, int disc);
void towerOfHanoi(int *source, int *aux, int *dest, int **towers, int n, int c);


int main()
{
    int n;
    printf("Numero de discos: ");
    scanf("%d", &n);
    printf("NUMERO DE DISCOS SELECCIONADOS: %d\n", n);

    int sourceTower[n];
    int auxiliarTower[n];
    int destinationTower[n];

    int *towers[3] = { sourceTower, destinationTower, auxiliarTower };

    for(int i = 0; i < n; i++)
    {
       sourceTower[i] = n - i;
       auxiliarTower[i] = 0;
       destinationTower[i] = 0;
    }

    printTowers(sourceTower, auxiliarTower, destinationTower, n);
    system("pause");

    towerOfHanoi(sourceTower, destinationTower, auxiliarTower, towers, n, n);

    return 0;
}


void printTowers(int *source, int *dest, int *aux, int discs)
{
    printf("Source\n--");

    for(int i = 0; i < discs; i++)
        printf("%d-", source[i]);
    printf("\n\n");
    
    printf("Auxiliar\n--");

    for(int i = 0; i < discs; i++)
        printf("%d-", aux[i]);
    printf("\n\n");

    printf("Destination\n--");

    for(int i = 0; i < discs; i++)
        printf("%d-", dest[i]);
    printf("\n\n");

    printf("\nIMPRESION\n");
}


void moveDisc(int *source, int *dest, int disc)
{
    int i = disc - 1;
    int j = 0;

    while(source[i] == 0 && disc >= 0)
        i--;

    while(dest[j] != 0)
        j++;

    dest[j] = source[i];
    source[i] = 0;

    printf("\nMOVIMIENTO\n");

}

void towerOfHanoi(int *source, int *aux, int *dest, int **towers, int n, int c)
{
    printf("\nINICIO DE TOWEROFHANOI()\n");

    
    if(n == 1)
    {
        moveDisc(source, aux, c);
        printTowers(towers[0], towers[1], towers[2], c);
        system("pause");
        return;
    }

    towerOfHanoi(source, dest, aux, towers, n-1, c);

    moveDisc(source, aux, c);
    printTowers(towers[0], towers[1], towers[2], c);
    system("pause");
    towerOfHanoi(dest, aux, source, towers, n-1, c);
}
