/*****************************************************************************/
// gcc -msse4.1 -O1 -o test_transpose test_transpose.c -lrt -lm

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>
#include <assert.h>
#include <xmmintrin.h>
#include <smmintrin.h>

#define TRUE 1
#define FALSE 0

#define GIG 1000000000
#define CPG 1.596           // Cycles per GHz -- Adjust to your computer

#define BASE  0
#define ITERS 256
#define DELTA 16
#define BSIZE 16

#define OPTIONS 2       // ij and ji -- need to add other methods

typedef float data_t;

/* Create abstract data type for vector */
typedef struct {
  long int len;
  data_t *data;
} vec_rec, *vec_ptr;

/*****************************************************************************/
main(int argc, char *argv[])
{
  int OPTION;
  struct timespec diff(struct timespec start, struct timespec end);
  struct timespec time1, time2;
  struct timespec time_stamp[OPTIONS][ITERS+1];
  int clock_gettime(clockid_t clk_id, struct timespec *tp);
  vec_ptr new_vec(long int len);
  int set_vec_length(vec_ptr v, long int index);
  long int get_vec_length(vec_ptr v);
  int init_vector(vec_ptr v, long int len);
  data_t *data_holder;
  void transpose(vec_ptr v0, vec_ptr v1);
  void transpose_rev(vec_ptr v0, vec_ptr v1);

  long int i, j, k, bsize = BSIZE;
  long int time_sec, time_ns;
  long int MAXSIZE = BASE+(ITERS+1)*DELTA;

  //printf("\n Hello World -- Transpose \n");

  // declare and initialize the vector structures
  vec_ptr v0 = new_vec(MAXSIZE);  vec_ptr v1 = new_vec(MAXSIZE);
  init_vector(v0, MAXSIZE);  init_vector(v1, MAXSIZE);

  OPTION = 0;
  for (i = 0; i < ITERS; i++) {
    set_vec_length(v0,BASE+(i+1)*DELTA);
    set_vec_length(v1,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    transpose(v0, v1);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
  }

  OPTION++;
  for (i = 0; i < ITERS; i++) {
    set_vec_length(v0,BASE+(i+1)*DELTA);
    set_vec_length(v1,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    transpose_rev(v0, v1);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[OPTION][i] = diff(time1,time2);
  }

  /* output times */
  //printf("\nsize,   ij,   ji, block = %d", BSIZE);  
  for (i = 0; i < ITERS; i++) {
    printf("\n%d, ", BASE+(i+1)*DELTA);
    for (j = 0; j < OPTIONS; j++) {
      if (j != 0) printf(", ");
      printf("%ld", (long int)((double)(CPG)*(double)
		 (GIG * time_stamp[j][i].tv_sec + time_stamp[j][i].tv_nsec)));
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

/************************************/

/* transpose */
void transpose(vec_ptr v0, vec_ptr v1)
{
  long int i, j;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v0);
  data_t *data0 = get_vec_start(v0);
  data_t *data1 = get_vec_start(v1);

  for (i = 0; i < length; i++)
    for (j = 0; j < length; j++)
      data1[j*length+i] = data0[i*length+j];
}

/* transpose */
void transpose_rev(vec_ptr v0, vec_ptr v1)
{
  long int ii, jj, i, j;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = BSIZE * (get_vec_length(v0)/BSIZE);
  long int extra =  get_vec_length(v0) - length;
  data_t *data0 __attribute__((__aligned__(16))) = get_vec_start(v0);
  data_t *data1 __attribute__((__aligned__(16))) = get_vec_start(v1);
  __m128 row1, row2, row3, row4;
  for (ii = 0; ii < length; ii+=BSIZE) {
    for (jj = 0; jj < length; jj+=BSIZE) {
       for (i = ii; i < ii + BSIZE; i+=4) {
          for (j = jj; j < jj + BSIZE; j+=4) {
            row1 = _mm_load_ps(&data0[i*length + j]);
            row2 = _mm_load_ps(&data0[i*length + j + 4]);
            row3 = _mm_load_ps(&data0[i*length + j + 8]);
            row4 = _mm_load_ps(&data0[i*length + j + 12]);
            _MM_TRANSPOSE4_PS(row1, row2, row3, row4);
            _mm_store_ps(&data1[j*length + i], row1); 
            _mm_store_ps(&data1[j*length + i + 4], row2);
            _mm_store_ps(&data1[j*length + i + 8], row3);
            _mm_store_ps(&data1[j*length + i + 12], row4);            
          }
       }
    }
  }
  for (i=0; i<extra; i++) {
     data1[i*length+j] = data0[j*length+i];
  }
}
