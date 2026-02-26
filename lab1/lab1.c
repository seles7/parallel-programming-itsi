#include <stdio.h>
#include <time.h>
#include <locale.h>
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
        : "%xmm0", "%xmm1"
    );
    return;
}

void sequential(float* a, float* b, float* c, int n)
{
    for (int i = 0; i < n; i++)
    {
        c[i] = a[i] * b[i];
    }
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

    double time1, time2;

    int n = 4;
    long iteration_number = 1e9;
    float totaltime_sse = 0.0f, totaltime_seq = 0.0f;

    float a[n];
    float b[n];
    float c[n];

    for (int i = 0; i < n; i++)
    {
        a[i] = (float)(rand() % 100) / 10;
        b[i] = (float)(rand() % 100) / 10;
    }
    
    printf("Масив a:\n");
    print_massiv(a, n);
    printf("Масив b:\n");
    print_massiv(b, n);

    int K = 10;
    for (int k = 0; k < K; k++)
    {
        printf("%d\n", k);
        time1 = clock();
        for (int i = 0; i < iteration_number; i++) sse(a, b, c);
        time2 = clock();
        totaltime_sse += time2 - time1;

        time1 = clock();
        for (int i = 0; i < iteration_number; i++) sequential(a, b, c, n);
        time2 = clock();
        totaltime_seq += time2 - time1;
    }
    totaltime_sse /= (K * CLOCKS_PER_SEC);
    totaltime_seq /= (K * CLOCKS_PER_SEC);

    printf("Масив c:\n");
    print_massiv(c, n);

    printf("\nС использованием sse инструкций.\n");
    printf("Среднее время рассчетов: %f\n", totaltime_sse);

    printf("\nПоследовательная программа.\n");
    printf("Среднее время рассчетов: %f\n", totaltime_seq);
    printf("\nПоследовательная программа медленнее в %f раза.\n", totaltime_seq / totaltime_sse);

    return 0;
}