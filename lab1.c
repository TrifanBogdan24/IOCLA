#include <stdio.h>

char dec_to_bin(int x)
{
    char *sir;
    int nr = 0;
    do {
        nr++; 
        x = x/2;
    } while(x!=0);
    printf("%s\n", sir);
    //return sir;

}
int main()
{
    dec_to_bin(121);
    //printf("Valoarea lui 121 in binar = %s", dec_to_bin(121));
    //printf("Valoarea lui 18446 in binar = %s", dec_to_bin(18446));
    return 0;
}