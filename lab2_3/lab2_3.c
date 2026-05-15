#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <pthread.h>
#include <math.h>
#include <sys/time.h>
#include <omp.h>

int counter = 0;
int iter_count = 1e9;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

void sqrt_task()
{
    for (int i = 0; i < iter_count; i++) 
    {
        sqrt(i);
    }
    return;
}

void *heavy_task(void *i) 
{
    int thread_num = *((int*) i);

    printf(" Поток №%d запущен\n", thread_num);
    pthread_mutex_lock(&mutex);
    printf("  Поток №%d занял мьютекс\n", thread_num);
    counter++;
    printf("   Поток №%d, значение счётчика: %d\n", thread_num, counter);
    printf("  Поток №%d освободил мьютекс\n", thread_num);
    pthread_mutex_unlock(&mutex);

    sqrt_task();

    printf(" Поток №%d завершил работу\n", thread_num);
    free(i);

    return NULL;
}

void pthreads(int threads_num) {
    pthread_t threads[threads_num];
    int status;
    for (int i = 0; i < threads_num; i++) {
        printf("Запуск потока №%d\n", i);
        int *thread_num = (int*) malloc(sizeof(int));
        *thread_num = i;
        status = pthread_create(&threads[i], NULL, heavy_task, thread_num);
        if (status != 0) {
            fprintf(stderr, "pthread_create failed, error code %d\n", status);
            exit(EXIT_FAILURE);
        }
    }
    for (int i = 0; i < threads_num; i++) {
        pthread_join(threads[i], NULL);
    }
    return;
}

void openmp(int thread_num)
{
    printf("Запуск программы с использованием OpenMP\n");
    omp_set_num_threads(thread_num);
    printf("Число потоков OpenMP: %d\n", omp_get_max_threads());

    #pragma omp parallel for
    for (int i = 0; i < thread_num; i++)
    {
        sqrt_task();
    }
    printf("Программа с OpenMP завершила работу\n");

    return;
}

void sequential(int threads_num)
{
    printf("Запуск последовательной операции.\n");
    for (int i = 0; i < threads_num; i++) 
    {
        sqrt_task();
    }
    printf("Последовательная операция завершена.\n");
    return;
}

int main(int argc, char** argv) 
{
    setlocale(LC_ALL, "ru");
    struct timeval time1, time2;
    double totaltime_pth, totaltime_omp, totaltime_seq;

    int threads_num = atoi(argv[1]);

    gettimeofday(&time1, NULL);
    pthreads(threads_num);
    gettimeofday(&time2, NULL);
    totaltime_pth = (double)time2.tv_sec + (double)time2.tv_usec / 1e6 - ((double)time1.tv_sec + (double)time1.tv_usec / 1e6);
    printf("\n");

    pthread_mutex_destroy(&mutex);

    gettimeofday(&time1, NULL);
    openmp(threads_num);
    gettimeofday(&time2, NULL);
    totaltime_omp = (double)time2.tv_sec + (double)time2.tv_usec / 1e6 - ((double)time1.tv_sec + (double)time1.tv_usec / 1e6);
    printf("\n");

    gettimeofday(&time1, NULL);
    sequential(threads_num);
    gettimeofday(&time2, NULL);
    totaltime_seq = (double)time2.tv_sec + (double)time2.tv_usec / 1e6 - ((double)time1.tv_sec + (double)time1.tv_usec / 1e6);
    printf("\n");

    printf("С использованием pthread: %f\n", totaltime_pth);   
    printf("С использованием openmp: %f\n", totaltime_omp);  
    printf("Последовательно: %f\n", totaltime_seq);
    printf("\n");

    printf("Pthread быстрее последовательной программы в %f раз\n", totaltime_seq / totaltime_pth);   
    printf("Openmp быстрее последовательной программы в %f раз\n", totaltime_seq / totaltime_omp); 
    printf("Разница между временами выполнения программы с помощью openmp и pthread: %f секунд\n", fabs(totaltime_pth - totaltime_omp)); 

    return 0;
}
