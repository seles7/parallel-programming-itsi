#include <iostream>
#include "xmmintrin.h"

void sse(float* a, float* b, float* c) 
{
  asm volatile (
                "movups %[a], %%xmm0\n"
                "movups %[b], %%xmm1\n"
                "mulps %%xmm1, %%xmm0\n"
                "movups %%xmm0, %[c]\n"
                :
                : [a]"m"(*a), [b]"m"(*b), [c]"m"(*c)
                : "%xmm0", "%xmm1");
    printf("\n");
    for (int i = 0; i < 4; i++)
    {
        printf("%f ", c[i]);
    }
    printf("\n");

    return;
}

void non_sse(float* a, float* b, float* c)
{

    return;
}

void print_massiv(float* mas, int n)
{
    printf("{");
    for (int i = 0; i < n; i++)
    {
        printf("%f", mas[i]);
        if (i < n - 1)
            printf("; ");
    }
    printf("}\n");
    return;
}

int main(int argc, char** argv)
{
    setlocale(LC_ALL, "ru");
    srand(time(0));

    int n = 4;

    float a[n];
    float b[n];
    float c[n];

    for (int i = 0; i < n; i++)
    {
        a[i] = float(rand() % 100) / 10;
        b[i] = float(rand() % 100) / 10;
    }
    
    printf("Масив a:\n");
    print_massiv(a, n);
    printf("Масив b:\n");
    print_massiv(b, n);

    //for (int i = 0; i < iterations_num; i++) {}
    
    sse(a, b, c);
    
    printf("Масив c:\n");
    print_massiv(c, n);

    return 0;
}