#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <omp.h>

#define CPG 1.596

#define BASE 0 
#define ITERS 1000 
#define DELTA 1 
#define MAXSIZE BASE+(ITERS+1)*DELTA
#define MIN -10
#define MAX 10
#define BLOCKSIZE 8 

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
            v->data[i*len + j] = (data_t) (rand() % (2*MAX) + MIN);
        }
    }    
}

void zero_vec(vec_ptr v) {
    long int i;
    long int len = v->len;
    for (i = 0; i < len*len; i++) {
        v->data[i] = (data_t) 0;
    }
}


void mmm_base(vec_ptr a, vec_ptr b, vec_ptr c) {
    long int len = c->len;
    data_t *adata = a->data;
    data_t *bdata = b->data;
    data_t *cdata = c->data;
    long int limit = BLOCKSIZE*(len/BLOCKSIZE); 
    long int ii, jj, kk, i, j, k;
    data_t r;
    
    for (ii = 0; ii < limit; ii += BLOCKSIZE) {
        for (jj = 0; jj < limit; jj += BLOCKSIZE) {
            for (kk = 0; kk < limit; kk += BLOCKSIZE) {
                for (i = ii; i < ii + BLOCKSIZE; i++) {
                    for (j = jj; j < jj + BLOCKSIZE; j++) {
                        r = 0;
                        for (k = kk; k < kk + BLOCKSIZE; k++) {
                            r += adata[i*len + k] * bdata[k*len + j];
                        }
                        cdata[i*len + j] = r;
                    }
                 }
            }
        }
    }
    //Leftover array elements
    for (i = limit; i < len; i++) {
        for (j = limit; j < len; j++) {
            r = 0;
            for (k = limit; k < len; k++) {
                r += adata[i*len + k] * bdata[k*len + j];
            }
            cdata[i*len + j] = r;
        }
    }
}


void mmm_opt_omp(vec_ptr a, vec_ptr b, vec_ptr c) {
    long int len = c->len;
    data_t *adata = a->data;
    data_t *bdata = b->data;
    data_t *cdata = c->data;
    long int limit = BLOCKSIZE*(len/BLOCKSIZE);
    long int i, j, k, ii, jj, kk;
    data_t r;
    
    omp_set_num_threads(4);
    for (ii = 0; ii < limit; ii += BLOCKSIZE) {
        for (jj = 0; jj < limit; jj += BLOCKSIZE) {
            for (kk = 0; kk < limit; kk += BLOCKSIZE) {
#pragma omp parellel shared(adata, bdata, cdata, len, ii, jj, kk) private(i, j, k, r)
{
#pragma omp parellel for 
               for (i = ii; i < ii + BLOCKSIZE; i++) {
                    for (j = jj; j < jj + BLOCKSIZE; j++) {
                        r = 0;
                        for (k = kk; k < kk + BLOCKSIZE; k++) {
                            r += adata[i*len + k] * bdata[k*len + j];
                        }
                        cdata[i*len + j] = r;
                    }
                 }
}
            }
        }
    }
#pragma omp parellel shared(adata, bdata, cdata, len) private (i, j, k, r)
{
#pragma omp for
    //Leftover array elements
    for (i = limit; i < len; i++) {
        for (j = limit; j < len; j++) {
            r = 0;
            for (k = 0; k < len; k++) {
                r += adata[i*len + k] * bdata[k*len + j];
            }
            cdata[i*len + j] = r;
        }
    }
}
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

    vec_ptr a = new_vec(MAXSIZE);
    vec_ptr b = new_vec(MAXSIZE);
    vec_ptr c = new_vec(MAXSIZE);
    init_vec(a); 
    init_vec(b);
    //printv(a);
    //printv(b);
     
    zero_vec(c);
    for (i = 0; i < ITERS; i++) {
        c->len = BASE+(i+1)*DELTA;
        clock_gettime(CLOCK_REALTIME, &start);
        mmm_base(a, b, c);
        clock_gettime(CLOCK_REALTIME, &stop);                
        timestamp[OPTION][i] = cycles(start, stop);
    }
    //printv(c);

    OPTION++;
    zero_vec(c);
    for (i = 0; i < ITERS; i++) {
        c->len = BASE+(i+1)*DELTA;
        clock_gettime(CLOCK_REALTIME, &start);
        mmm_opt_omp(a, b, c);
        clock_gettime(CLOCK_REALTIME, &stop);
        timestamp[OPTION][i] = cycles(start, stop);
    }
    //printv(c);

    for (i = 0; i < ITERS; i++) {
        printf("\n%d", BASE+(i+1)*DELTA);
        for (j = 0; j < OPTIONS; j++) {
            printf(", %ld", timestamp[j][i]);
        }   
    }

    printf("\n");
} 
