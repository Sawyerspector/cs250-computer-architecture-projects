#include <stdio.h>
#include <stdlib.h>



int recurse(int n)
{
    if(n == 0)
    {
        return 2;
    }
    else
    {
        return 2 * (n + 1) + 3 * recurse(n - 1) + 9;
    }
}

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        return EXIT_SUCCESS;
    }
    long long num = atoll(argv[1]);
    printf("%d\n", recurse((int)num));
    return EXIT_SUCCESS;
    
}