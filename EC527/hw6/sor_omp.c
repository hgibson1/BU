#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <omp.h>

#define CPG 1.596

#define BASE 0 
#define ITERS 128 
#define DELTA 1 
#define MAXSIZE BASE+(ITERS+1)*DELTA
#define MIN -10
#define MAX 10
#define BLOCKSIZE 8 
#define TOL 0.001
#define OMEGA 1

#define OPTIONS 2 

typedef double data_t;


typedef struct {
    long int len;
    data_t *data;
} vec_rec, *vec_ptr;

inline long int cycles(struct timespec start, struct timespec stop) {
    return (long int) (CPG * (10e9*((double)(stop.tv_sec - start.tv_sec)) + (double)(stop.tv_nsec - start.tv_nsec)));
}


vec_ptr new_vec(long int len) {
    long int i;
    vec_ptr result = (vec_ptr) malloc(sizeof(vec_rec));
    if (!result) return NULL; 
        result->len = len;
    if (len > 0) { 
        data_t *data = (data_t *) calloc(len*len, sizeof(data_t));
        if (!data) {
            free((void *) result);
            printf("\n COULDN'T ALLOCATE STORAGE \n", result->len);
            return NULL;  
        }
        result->data = data;
    } else result->data = NULL;
    return result;
}


void init_vec(vec_ptr v) {
    long int i, j;
    long int len = v->len;
    for (i = 0; i < len; i++) {
        for (j = 0; j < len; j++) {
            v->data[i*len + j] = (data_t) ((i*len + j) % MAX);
        }
    }    
}


void sor_base(vec_ptr v, int *iterations) {
    long int len = v->len;
    data_t *data = v->data;
    long int limit = BLOCKSIZE*(len/BLOCKSIZE);
    long int i, j, ii, jj;
    int iters = 0;

    data_t change, mean_change = (data_t) 100;
    while ((mean_change/(data_t)(len*len)) > (data_t) TOL) {
        iters++;
        mean_change = 0;
        for (ii = 1; ii < limit; ii += BLOCKSIZE) {
            for (jj = 1; jj < limit; jj += BLOCKSIZE) {
                for (i = ii; i < ii + BLOCKSIZE; i++) {
                    for (j = jj; j < jj + BLOCKSIZE; j++) {
                        change = data[i*len + j] - 0.25 * (
                            data[(i-1)*len + j] +
                            data[(i+1)*len + j] +
                            data[i*len + j - 1] +
                            data[i*len + j + 1]
                        );
                        data[i*len + j] -= change * OMEGA;
                        if (change < 0) {
                            change = -change;
                        }
                        mean_change += change;
                    }
                }
            }
        }
        //Finish leftovers
        for (i = limit; i < len - 1; i++) {
            for (j = limit; j < len - 1; j++) {
                change = data[i*len + j] - 0.25 * (
                    data[(i-1)*len + j] +
                    data[(i+1)*len + j] +
                    data[i*len + j - 1] +
                    data[i*len + j + 1]
                );
                data[i*len + j] -= change * OMEGA;
                if (change < 0) {
                    change = -change;
                }
                mean_change += change;
            }
        }
    }
    *iterations = iters;        
}


void sor_opt_omp(vec_ptr v, int *iterations) {
    long int len = v->len;
    data_t *data = v->data;
    long int limit = BLOCKSIZE*(len/BLOCKSIZE);
    long int i, j, ii, jj;
    int iters = 0;

    omp_set_num_threads(8);
    data_t change, mean_change = (data_t) 100;
    while ((mean_change/(data_t)(len*len)) > (data_t) TOL) {
        iters++;
        mean_change = 0;
        for (ii = 1; ii < limit; ii += BLOCKSIZE) {
            for (jj = 1; jj < limit; jj += BLOCKSIZE) {
#pragma omp parellel shared(data, len, ii, jj, mean_change) private(i, j, change)
{
#pragma omp for
                for (i = ii; i < ii + BLOCKSIZE; i++) {
                    for (j = jj; j < jj + BLOCKSIZE; j++) {
                        change = data[i*len + j] - 0.25 * (
                            data[(i-1)*len + j] +
                            data[(i+1)*len + j] +
                            data[i*len + j - 1] +
                            data[i*len + j + 1]
                        );
                        data[i*len + j] -= change * OMEGA;
                        if (change < 0) {
                            change = -change;
                        }
                        mean_change += change;
                    }
                }
}
            }
        }
#pragma omp parellel shared(data, len, mean_change) private(i, j, change)
{
#pragma omp for
        for (i = limit; i < len - 1; i++) {
            for (j = limit; j < len - 1; j++) {
                change = data[i*len + j] - 0.25 * (
                    data[(i-1)*len + j] +
                    data[(i+1)*len + j] +
                    data[i*len + j - 1] +
                    data[i*len + j + 1]
                );
                data[i*len + j] -= change * OMEGA;
                if (change < 0) {
                    change = -change;
                }
                mean_change += change;
            }
        }
    }
}
    *iterations = iters;        
}


void printv(vec_ptr v) {
    long int len = v->len;
    long int i, j;
    for (i = 0; i < len; i++) {
        for (j = 0; j < len - 1; j++) {
            printf("%2.2f, ", (double) v->data[i*len + j]);
        }
        printf("%2.2f\n", (double) v->data[i*len + j]);
    }
    printf("\n");
}

main(int argc, char *argv[]) {
    int OPTION = 0;
    long int i, j;
    struct timespec start, stop;
    long int timestamp[OPTIONS][ITERS+1];
    int iters[OPTIONS][ITERS+1];
    int *iterations = (int *) malloc(sizeof(int));
    vec_ptr v = new_vec(MAXSIZE);
    init_vec(v); 
    //printv(v);
     
    for (i = 0; i < ITERS; i++) {
        v->len = BASE+(i+1)*DELTA;
        clock_gettime(CLOCK_REALTIME, &start);
        sor_base(v, iterations);
        clock_gettime(CLOCK_REALTIME, &stop);                
        timestamp[OPTION][i] = cycles(start, stop);
        iters[OPTION][i] = *iterations;
    }
    //printv(v);

    OPTION++;
    init_vec(v);
    for (i = 0; i < ITERS; i++) {
        v->len = BASE+(i+1)*DELTA;
        clock_gettime(CLOCK_REALTIME, &start);
        sor_opt_omp(v, iterations);
        clock_gettime(CLOCK_REALTIME, &stop);
        timestamp[OPTION][i] = cycles(start, stop);
        iters[OPTION][i] = *iterations;
    }
    //printv(v);

    for (i = 0; i < ITERS; i++) {
        printf("\n%d", BASE+(i+1)*DELTA);
        for (j = 0; j < OPTIONS; j++) {
            printf(", %ld, %d", timestamp[j][i], iters[j][i]);
        }   
    }

    printf("\n");
} 
