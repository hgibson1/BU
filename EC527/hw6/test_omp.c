
// gcc -O1 -fopenmp -o test_omp test_omp.c -lrt -lm
// export NUM_OMP_THREADS=4

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <omp.h>

#define NUM_THREADS 4

char hello[12] = {'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd', '!'};

main(int argc, char *argv[]) {
    //printf("\n Hello World -- Test OMP \n");
    omp_set_num_threads(NUM_THREADS);

    printf("With omp sections: ");
    #pragma omp parallel
    #pragma omp sections
    {
        #pragma omp section
            printf("H");
        #pragma omp section
            printf("e");
        #pragma omp section
            printf("l");
        #pragma omp section
            printf("l");
        #pragma omp section
            printf("o");
        #pragma omp section
            printf(" ");
        #pragma omp section
            printf("W");
        #pragma omp section
            printf("o");
        #pragma omp section
            printf("r");
        #pragma omp section
            printf("l");
        #pragma omp section
            printf("d");
        #pragma omp section
            printf("!");
    }
    printf("\n");
  
    short int i = 0;
    printf("With omp for: ");
    #pragma omp parallel for
        for (i=0; i<12; i++) {
            printf("%c", hello[i]);
        }
    printf("\n");
}

