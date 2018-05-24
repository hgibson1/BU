/*****************************************************************************/
// gcc -pthread -o test_SOR_pt2 test_SOR_pt2.c -lrt -lm

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <pthread.h>

#define GIG 1000000000
#define CPG 2.9           // Cycles per GHz -- Adjust to your computer

#define BASE 1023 
#define ITERS 1
#define DELTA 1

#define OPTIONS 6 
#define BLOCK_SIZE 8     // TO BE DETERMINED

#define MINVAL   0.0
#define MAXVAL  10.0

#define TOL 0.00001
#define OMEGA 1       // TO BE DETERMINED

typedef double data_t;

pthread_barrier_t barr1, barr2, barr3;
pthread_mutex_t crit;

/* Create abstract data type for vector -- here a 2D array */
typedef struct {
  long int len;
  data_t *data;
} vec_rec, *vec_ptr;

int NUM_THREADS;

struct thread_data {
    int thread_id;
    vec_ptr v;
};

main(int argc, char *argv[])
{
  int OPTION;
  struct timespec diff(struct timespec start, struct timespec end);
  struct timespec time1, time2;
  struct timespec time_stamp[OPTIONS][ITERS+1];
  int convergence[OPTIONS][ITERS+1];
  vec_ptr new_vec(long int len);
  int set_vec_length(vec_ptr v, long int index);
  long int get_vec_length(vec_ptr v);
  int init_vector(vec_ptr v, long int len);
  int init_vector_rand(vec_ptr v, long int len);
  int print_vector(vec_ptr v);
  void SOR(vec_ptr v, int *iterations);
  void SOR_blocked(vec_ptr v, int *iterations);
  void SOR_pt(vec_ptr v, int *iterations);
  void SOR_blocked_pt(vec_ptr v, int *iterations); 
 
  long int i, j;
  long int time_sec, time_ns;
  long int MAXSIZE = BASE+(ITERS+1)*DELTA;

  //printf("\n Hello World -- SOR serial variations \n");

  // declare and initialize the vector structure
  vec_ptr v0 = new_vec(MAXSIZE);
  int *iterations = (int *) malloc(sizeof(int));

  OPTION = 0;
  for (i = 0; i < ITERS; i++) {
    //printf("\niter = %d length = %d OMEGA = %0.2f", i, BASE+(i+1)*DELTA, OMEGA);
    set_vec_length(v0, BASE+(i+1)*DELTA);
    init_vector_rand(v0, BASE+(i+1)*DELTA);
    //print_vector(v0);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
    
  }
  

  OPTION++;
  for (i = 0; i < ITERS; i++) {
    init_vector_rand(v0, BASE+(i+1)*DELTA); 
    set_vec_length(v0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR_blocked(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
  }
    
  NUM_THREADS = 2;
  OPTION++;
  for (i=0; i<ITERS; i++) {
    init_vector_rand(v0, BASE+(i+1)*DELTA);
    set_vec_length(v0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR_pt(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
  }
   
  NUM_THREADS = 4;
  OPTION++;
  for (i=0; i<ITERS; i++) {
    init_vector_rand(v0, BASE+(i+1)*DELTA);
    set_vec_length(v0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR_pt(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
  }

  /*  
  NUM_THREADS = 2;
  OPTION++;
  for (i=0; i<ITERS; i++) {
    init_vector_rand(v0, BASE+(i+1)*DELTA);
    set_vec_length(v0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR_blocked_pt(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
  }
  
  NUM_THREADS = 4;
  OPTION++;
  for (i=0; i<ITERS; i++) {
    init_vector_rand(v0, BASE+(i+1)*DELTA);
    set_vec_length(v0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    SOR_blocked_pt(v0,iterations);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
    convergence[OPTION][i] = *iterations;
  }
  */
  for (i = 0; i < ITERS; i++) {
    printf("\n%d, ", BASE+(i+1)*DELTA);
    for (j = 0; j < OPTION + 1; j++) {
      if (j != 0) printf(", ");
      printf("%ld", (long int)((double)(CPG)*(double)
		 (GIG * time_stamp[j][i].tv_sec + time_stamp[j][i].tv_nsec)));
      printf(", %d", convergence[j][i]);
    }
  }

  printf("\n");
  
}/* end main */
/*********************************/

/* Create 2D vector of specified length per dimension */
vec_ptr new_vec(long int len)
{
  long int i;

  /* Allocate and declare header structure */
  vec_ptr result = (vec_ptr) malloc(sizeof(vec_rec));
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

/* Set length of vector */
int set_vec_length(vec_ptr v, long int index)
{
  v->len = index;
  return 1;
}

/* Return length of vector */
long int get_vec_length(vec_ptr v)
{
  return v->len;
}

/* initialize 2D vector */
int init_vector(vec_ptr v, long int len)
{
  long int i;

  if (len > 0) {
    v->len = len;
    for (i = 0; i < len*len; i++) v->data[i] = (data_t)(i);
    return 1;
  }
  else return 0;
}

/* initialize vector with another */
int init_vector_rand(vec_ptr v, long int len)
{
  long int i;
  double fRand(double fMin, double fMax);

  if (len > 0) {
    v->len = len;
    for (i = 0; i < len*len; i++)
      v->data[i] = (data_t)(fRand((double)(MINVAL),(double)(MAXVAL)));
    return 1;
  }
  else return 0;
}

/* print vector */
int print_vector(vec_ptr v)
{
  long int i, j, len;

  len = v->len;
  //printf("\n length = %ld", len);
  for (i = 0; i < len; i++) {
    printf("\n");
    for (j = 0; j < len; j++)
      printf("%.4f ", (data_t)(v->data[i*len+j]));
  }
  printf("\n");
}

data_t *get_vec_start(vec_ptr v)
{
  return v->data;
}

/************************************/

struct timespec diff(struct timespec start, struct timespec end)
{
  struct timespec temp;
  if ((end.tv_nsec-start.tv_nsec)<0) {
    temp.tv_sec = end.tv_sec-start.tv_sec-1;
    temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
  } else {
    temp.tv_sec = end.tv_sec-start.tv_sec;
    temp.tv_nsec = end.tv_nsec-start.tv_nsec;
  }
  return temp;
}

double fRand(double fMin, double fMax)
{
    double f = (double)random() / RAND_MAX;
    return fMin + f * (fMax - fMin);
}

/************************************/

/* SOR */
void SOR(vec_ptr v, int *iterations)
{long int i, j;
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);
  double change, mean_change = 100;   // start w/ something big
  int iters = 0;

  while ((mean_change/(double)(length*length)) > (double)TOL) {
    iters++;
    mean_change = 0;
    for (i = 1; i < length-1; i++)
      for (j = 1; j < length-1; j++) {
        change = data[i*length+j] - .25 * (data[(i-1)*length+j] +
                                          data[(i+1)*length+j] +
                                          data[i*length+j+1] +
                                          data[i*length+j-1]);
        data[i*length+j] -= change * OMEGA;
        if (change < 0){
          change = -change;
        }
        mean_change += change;
      }
    if (abs(data[(length-2)*(length-2)]) > 10.0*(MAXVAL - MINVAL)) {
      printf("\n PROBABLY DIVERGENCE iter = %ld", iters);
      break;
    }
  }
   *iterations = iters;
}

/* SOR w/ blocking */
void SOR_blocked(vec_ptr v, int *iterations)
{
  long int i, j, ii, jj;
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);
  double change, mean_change = 100;
  int iters = 0;
  int k;

  while ((mean_change/(double)(length*length)) > (double)TOL) {
    iters++;
    mean_change = 0;
    for (ii = 1; ii < length-1; ii+=BLOCK_SIZE) 
      for (jj = 1; jj < length-1; jj+=BLOCK_SIZE)
	for (i = ii; i < ii+BLOCK_SIZE; i++)
	  for (j = jj; j < jj+BLOCK_SIZE; j++) {
	    change = data[i*length+j] - .25 * (data[(i-1)*length+j] +
					      data[(i+1)*length+j] +
					      data[i*length+j+1] +
					      data[i*length+j-1]);
	    data[i*length+j] -= change * OMEGA;
	    if (change < 0){
	      change = -change;
	    }
	    mean_change += change;
	  }
    if (abs(data[(length-2)*(length-2)]) > 10.0*(MAXVAL - MINVAL)) {
      printf("\n PROBABLY DIVERGENCE iter = %d", iters);
      break;
    }
  }
  *iterations = iters;
  //printf("\n iters = %d", iters);
}

void* SOR_pt_work(void *arg) {
  long int i, j, low, high, rc;
  struct thread_data *tdata = (struct thread_data *) arg;
  int taskid = tdata->thread_id;
  vec_ptr v = tdata->v;
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);
  low = 1 + (taskid*(length)/NUM_THREADS);
  high = low + (length)/NUM_THREADS - 1;

  double change, mean_change = 100;   // start w/ something big
  int iters = 0, done = 0;
  
  while (!done) {
    iters++;
    mean_change = 0;
    rc = pthread_barrier_wait(&barr1);
    if (rc !=0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 1\n");
        exit(-1);
    }
   for (i = low; i < high; i++) 
      for (j = 1; j < length - 1; j++) {
	change = data[i*length+j] - .25 * (data[(i-1)*length+j] +
					  data[(i+1)*length+j] +
					  data[i*length+j+1] +
					  data[i*length+j-1]);
	data[i*length+j] -= change * OMEGA;
	if (change < 0){
	  change = -change;
	}
        //Lock
        pthread_mutex_lock(&crit);
	mean_change += change;
        //Unlock
        pthread_mutex_unlock(&crit);
      }
    if (abs(data[(length-2)*(length-2)]) > 10.0*(MAXVAL - MINVAL)) {
      printf("\n PROBABLY DIVERGENCE iter = %ld", iters);
      break;
    }
    //barrier
    rc = pthread_barrier_wait(&barr2);
    if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 2\n");
        exit(-1);
    }
    if (mean_change/(double)(length*length) > (double) TOL) done = 1;
    //barier
    rc = pthread_barrier_wait(&barr3);
    if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 3\n");
        exit(-1);
    }
  }
  pthread_exit((void*) iters);
} 

void SOR_pt(vec_ptr v, int *iterations) {
   long int t, rc;
   if (pthread_barrier_init(&barr1, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 1\n");
       exit(-1);
   } else if (pthread_barrier_init(&barr2, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 2\n");
       exit(-1);
   } else if (pthread_barrier_init(&barr3, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 3\n");
       exit(-1);
   }
   pthread_mutex_init(&crit, NULL);
   
   void *titers = (void *) malloc(64); 
   int iters = 0;
  
   pthread_t threads[NUM_THREADS];
   struct thread_data thread_data_array[NUM_THREADS + 1];
   for (t=0; t<NUM_THREADS; t++) {
       thread_data_array[t].thread_id = t;
       thread_data_array[t].v = v;
       rc = pthread_create(&threads[t], NULL, SOR_pt_work, &thread_data_array[t]);
       if (rc) {
           printf("Create error thread %d code %d\n", t, rc);
           exit(-1);
       }
   }
      
   for (t=0; t<NUM_THREADS; t++) {
       thread_data_array[t].thread_id = t;
       thread_data_array[t].v = v;
       rc = pthread_join(threads[t], (void **) &titers);
       if (rc) {
           printf("Join error thread %d code %d\n", t, rc);
       }
       //iters += *((int*) titers);
   }
   *iterations = iters;
}

void* SOR_blocked_pt_work(void *arg) {
  long int i, j, ii, jj, low, high, rc;
  struct thread_data *tdata = (struct thread_data *) arg;
  int taskid = tdata->thread_id;
  vec_ptr v = tdata->v;
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);
  low = 1 + (taskid*(length)/NUM_THREADS);
  high = low + (length)/NUM_THREADS - 1;

  double change, mean_change = 100;   // start w/ something big
  int iters = 0, done = 0;
  
  while (!done) {
    iters++;
    mean_change = 0;
    rc = pthread_barrier_wait(&barr1);
    if (rc !=0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 1\n");
        exit(-1);
    }
   for (ii = low; ii < high; ii+=BLOCK_SIZE) 
      for (jj = 1; jj < length - 1; jj+=BLOCK_SIZE) 
	 for (i = ii; i < ii + BLOCK_SIZE; i++) 
             for (j = jj; j < jj + BLOCK_SIZE; j++) {
         change = data[i*length+j] - .25 * (data[(i-1)*length+j] +
					  data[(i+1)*length+j] +
					  data[i*length+j+1] +
					  data[i*length+j-1]);
	data[i*length+j] -= change * OMEGA;
	if (change < 0){
	  change = -change;
	}
        //Lock
        pthread_mutex_lock(&crit);
	mean_change += change;
        //Unlock
        pthread_mutex_unlock(&crit);
      }
    if (abs(data[(length-2)*(length-2)]) > 10.0*(MAXVAL - MINVAL)) {
      printf("\n PROBABLY DIVERGENCE iter = %ld", iters);
      break;
    }
    //barrier
    rc = pthread_barrier_wait(&barr2);
    if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 2\n");
        exit(-1);
    }
    if (mean_change/(double)(length*length) > (double) TOL) done = 1;
    //barier
    rc = pthread_barrier_wait(&barr3);
    if (rc != 0 && rc != PTHREAD_BARRIER_SERIAL_THREAD) {
        printf("No Wait Barrier 3\n");
        exit(-1);
    }
  }
  pthread_exit((void*) iters);
} 

void SOR_blocked_pt(vec_ptr v, int *iterations) {
   long int t, rc;
   if (pthread_barrier_init(&barr1, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 1\n");
       exit(-1);
   } else if (pthread_barrier_init(&barr2, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 2\n");
       exit(-1);
   } else if (pthread_barrier_init(&barr3, NULL, NUM_THREADS)) {
       printf("Couldn't init barrier 3\n");
       exit(-1);
   }
   pthread_mutex_init(&crit, NULL);
   
   void *titers = (void *) malloc(64); 
   int iters = 0;
  
   pthread_t threads[NUM_THREADS];
   struct thread_data thread_data_array[NUM_THREADS + 1];
   for (t=0; t<NUM_THREADS; t++) {
       thread_data_array[t].thread_id = t;
       thread_data_array[t].v = v;
       rc = pthread_create(&threads[t], NULL, SOR_blocked_pt_work, &thread_data_array[t]);
       if (rc) {
           printf("Create error thread %d code %d\n", t, rc);
           exit(-1);
       }
   }
      
   for (t=0; t<NUM_THREADS; t++) {
       thread_data_array[t].thread_id = t;
       thread_data_array[t].v = v;
       rc = pthread_join(threads[t], (void **) &titers);
       if (rc) {
           printf("Join error thread %d code %d\n", t, rc);
       }
       //iters += *((int*) titers);
   }
   *iterations = iters;
}
