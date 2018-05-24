//gcc -pthread -O1 -o test_SOR_pt test_SOR_pt.c -lm -lrt

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <math.h>
#include <pthread.h>

#define CPG 2.9           // Cycles per GHz -- Adjust to your computer

#define BASE 2 
#define ITERS 1
#define DELTA 1
#define MAXSIZE BASE+(ITERS+1)*DELTA

#define TOL 0.01
#define OMEGA 1

#define OPTIONS 6      
#define BLOCKSIZE 2 

typedef double data_t;

inline long int cycles(struct timespec stop, struct timespec start) {
    return (long int) (((double) CPG) * ((double) (
        (stop.tv_sec - start.tv_sec) + 
        10e9*(stop.tv_nsec - start.tv_nsec)
    ))); 
}


/* Create abstract data type for matrix */
typedef struct {
    long int len;
    data_t *data;
} matrix_rec, *matrix_ptr;

int NUM_THREADS;

/* used to pass parameters to worker threads */
struct thread_data {
    int thread_id;
    matrix_ptr m;
};


void SOR(matrix_ptr m, int *iterations) {
    long int i, j;
    long int len = m->len;
    data_t *data = m->data;
    double change, mean_change = 100;
    int iters = 0;
    while ((mean_change/((double) (len*len))) > (double) TOL) {
        for (i=1; i<len-1; i++) {
            for (j=1; j<len-1; j++) {
                change = data[i*len+j] - 0.25 * (
                    data[(i+1)*len+j] +
                    data[(i-1)*len+j] +
                    data[i*len+j+1] +
                    data[i*len+j-1] 
                );
                data[i*len+j] -= change * OMEGA;
                if (change < 0) {
                    change = -change;
                }
                mean_change += change;
            } 
        }
    }
    *iterations = iters;
}

void SOR_B(matrix_ptr m, int *iterations) {
    long int i, j, ii, jj;
    long int len = m->len;
    data_t *data = m->data;
    double change, mean_change = 100;
    int iters = 0;
    while ((mean_change/((double)(len*len))) > (double) TOL) {
        iters++;
        mean_change = 0;
        for (ii=1; ii<len; ii+=BLOCKSIZE) {
            for(jj=1; jj<len; jj+=BLOCKSIZE) {
                for (i=ii; i<ii+BLOCKSIZE; i++) {
                    for (j=jj; j<jj+BLOCKSIZE; j++) {
                        change = data[i*len+j] - 0.25 * (
                            data[(i+1)*len+j] +
                            data[(i-1)*len+j] +
                            data[i*len+j+1] +
                            data[i*len+j-1]
                         );
                         data[i*len+j] -= change * OMEGA;
                         if (change < 0) {
                             change = -change;
                         }
                         mean_change += change;
                     }
                 }
             }
         }
    }
    *iterations = iters;
}

void *SOR_pt_work(void *arg) {
    long int i, j, low, high;
    int iters = 0;
    struct thread_data *tdata = (struct thread_data *) arg;
    int taskid = tdata->thread_id;
    matrix_ptr m = tdata->m;
    long int len = m->len;
    data_t *data = m->data;
    low = (taskid * len * len)/NUM_THREADS;
    high = ((taskid+1) * len * len)/NUM_THREADS;
    double change, mean_change = 100;
    
    while((mean_change/((double) (high*high))) > (double) TOL) {
        iters++;
        mean_change = 0;
        for (i=low; i<high; i++) {
            for (j=low; j<high; j++) {
                change = data[i*len+j] - 0.25 * (
                    data[(i+1)*len+j] +
                    data[(i-1)*len+j] +
                    data[i*len+j+1] +
                    data[i*len+j-1]
                );
                data[i*len+j] -= change * OMEGA;
                if (change < 0) {
                    change = -change;
                }
                mean_change += change;                       
            }
        }
    }
    pthread_exit((void*) iters);
}

void SOR_pt(matrix_ptr m, int *iterations) {
    long int t, rc;
    pthread_t threads[NUM_THREADS];
    struct thread_data thread_data_array[NUM_THREADS];
    for (t=0; t<NUM_THREADS; t++) {
        thread_data_array[t].thread_id = t;
        thread_data_array[t].m = m;
        rc = pthread_create(&threads[t], NULL, SOR_pt_work, &thread_data_array[t]);
        if (rc) {
            printf("Error, %d pthread_create return code %d\n", t, rc);
            exit(-1);
        }
    }
    int iters = 0;
    void *titers = (void *) malloc(sizeof(int));
    for (t=0; t<NUM_THREADS; t++) {
        rc = pthread_join(threads[t], &titers);
        if (rc) {
            printf("Error, return code from %d join is %d\n", t, rc);
            exit(-1);
        }
        iters += (int) titers;
    }
    *iterations = iters;
}

void *SOR_ptB_work(void *arg) {
    long int i, j, ii, jj, low, high;
    int iters = 0;
    struct thread_data *tdata = (struct thread_data *) arg;
    int taskid = tdata->thread_id;
    matrix_ptr m = tdata->m;
    long int len = m->len;
    data_t *data = m->data;
    low = (taskid * len * len)/NUM_THREADS;
    high = ((taskid+1) * len * len)/NUM_THREADS;
    double change, mean_change = 100;
    
    while((mean_change/((double) (high*high))) > (double) TOL) {
        iters++;
        mean_change = 0;
        for (ii=low; ii<high; ii+=BLOCKSIZE) {
            for (jj=low; jj<high; jj+=BLOCKSIZE) {
                for (i=ii; i<ii+BLOCKSIZE; i++) {
                    for (j=jj; j<jj+BLOCKSIZE; j++) {
                        change = data[i*len+j] - 0.25 * (
                            data[(i+1)*len+j] +
                            data[(i-1)*len+j] +
                            data[i*len+j+1] +
                            data[i*len+j-1]
                        );
                        data[i*len+j] -= change * OMEGA;
                        if (change < 0) {
                            change = -change;
                        }
                        mean_change += change;
                    }
                }                  
            }
        }
    }
    pthread_exit((void*) iters);
}

void SOR_ptB(matrix_ptr m, int *iterations) {
    long int t, rc;
    pthread_t threads[NUM_THREADS];
    struct thread_data thread_data_array[NUM_THREADS];
    for (t=0; t<NUM_THREADS; t++) {
        thread_data_array[t].thread_id = t;
        thread_data_array[t].m = m;
        rc = pthread_create(&threads[t], NULL, SOR_ptB_work, &thread_data_array[t]);
        if (rc) {
            printf("Error, %d pthread_create return code %d\n", t, rc);
            exit(-1);
        }
    }
    int iters = 0;
    void *titers = (void *) malloc(sizeof(int));
    for (t=0; t<NUM_THREADS; t++) {
        rc = pthread_join(threads[t], &iters);
        if (rc) {
            printf("Error, return code from %d join is %d\n", t, rc);
            exit(-1);
        }
        iters += (int) titers;
    }
    *iterations = iters;
}


void printm(matrix_ptr m) {
    long int len = m->len;
    data_t *data = m->data;
    long int i;
    for (i=0; i<len*len; i++) {
        printf("%.f ", data[i]);
    }
}

int main(int argc, char *argv[]) {
    int OPTION, i, j;
    struct timespec time1, time2;
    long int time_stamp[OPTIONS][ITERS+1];
    int convergence[OPTIONS][ITERS+1];
    matrix_ptr new_matrix(long int len);
    int init_matrix(matrix_ptr m, long int len);
    //void printm(matrix_ptr m);
    //void SOR(matrix_ptr m, int *iterations);
    //void SOR_B(matrix_ptr m, int *iterations);
    //void SOR_pt(matix_ptr m, int *iterations);
    //void SOR_ptB(matrix_ptr m, int *iterations);

    // declare and initialize the vector structure
    matrix_ptr m0 = new_matrix(MAXSIZE);
    init_matrix(m0, MAXSIZE);
    //printm(m0);
    
    int *iterations = (int *) malloc(sizeof(int));   
    OPTION = 0;
    for (i=0; i<ITERS; i++) {
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
        SOR(m0, iterations);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
        time_stamp[OPTION][i] = cycles(time2, time1);    
        convergence[OPTION][i] = *iterations;
    }
    //printm(m0);

    OPTION++;
    for (i=0; i<ITERS; i++) {
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
        SOR_B(m0, iterations);   
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
        time_stamp[OPTION][i] = cycles(time2, time1);
        convergence[OPTION][i] = *iterations;
    }
    //printm(m0);
    /*    
    NUM_THREADS = 2;
    OPTION++;
    for (i=0; i<ITERS; i++) {
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
        SOR_pt(m0, iterations);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
        time_stamp[OPTION][i] = cycles(time2, time1);
        convergence[OPTION][i] = *iterations;
    }
    printm(m0);
    
    OPTION++;
    for (i=0; i<ITERS; i++) {
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
        SOR_ptB(m0, iterations);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
        time_stamp[OPTION][i] = cycles(time2, time1);
        convergence[OPTION][i] = *iterations;
    }
    printm(m0);
    */
    for (i=0; i<ITERS; i++) {
         printf("\n%d", BASE+(i+1)*DELTA);
         for (j=0; j<OPTION; j++) {
             printf(", %ld, %d", time_stamp[j][i], convergence[j][i]);
         }
    }
}

matrix_ptr new_matrix(long int len) {
    long int i;
    /* Allocate and declare header structure */
    matrix_ptr result = (matrix_ptr) malloc(sizeof(matrix_rec));
    if (!result) return NULL;  /* Couldn't allocate storage */
    result->len = len;
    /* Allocate and declare array */
    if (len > 0) {
        data_t *data = (data_t *) calloc(len*len, sizeof(data_t));
        if (!data) {
            free((void *) result);
            printf("\n COULDN'T ALLOCATE STORAGE \n", result->len);
            return NULL;  /* Couldn't allocate storage */
        }
        result->data = data;
    }
    else result->data = NULL;
    return result;
}

int init_matrix(matrix_ptr m, long int len) {
    long int i;
    if (len > 0) {
       m->len = len;
       for (i = 0; i < len*len; i++)
           m->data[i] = (data_t) i;//(data_t)(((double) random() / (double) RAND_MAX));
       return 1;
    }
    else return 0;
}



