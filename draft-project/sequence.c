#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        return EXIT_SUCCESS;
    }
    long long num = atoll(argv[1]);
    long long numthird = num * num * num - 3;
    printf("%lld\n", numthird);
    return EXIT_SUCCESS;
}