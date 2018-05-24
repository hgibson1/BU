/*****************************************************************************/

// gcc -o test_dot test_dot.c -lrt

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>

#define SIZE 10000000
#define ITERS 200 
#define DELTA 1
#define BASE 0

#define IDENT 1.0 
#define OP *  

typedef double data_t;

/* Create abstract data type for vector */
typedef struct {
  long int len;
  data_t *data;
} vec_rec, *vec_ptr;

inline long int cycles(struct timespec * p_tv)
{
    return(long int)((((double) p_tv->tv_sec) * 1e9 + ((double) p_tv->tv_nsec))*1.596);
}

//struct timespec {
//  time_t tv_sec; /* seconds */
//  long tv_nsec;  /* nanoseconds */
//};

/*****************************************************************************/
main(int argc, char *argv[])
{
  struct timespec diff(struct timespec start, struct timespec end);
  struct timespec time1, time2;
  struct timespec time_stamp[ITERS+1];
  struct timespec time_stamp_opt[ITERS+1];
  int clock_gettime(clockid_t clk_id, struct timespec *tp);
  vec_ptr new_vec(long int len);
  int get_vec_element(vec_ptr v, long int index, data_t *dest);
  long int get_vec_length(vec_ptr v);
  int set_vec_length(vec_ptr v, long int index);
  int init_vector(vec_ptr v, long int len);
  data_t *data_holder;
  void dot(vec_ptr v, vec_ptr w, data_t *dest);
  void dot_opt(vec_ptr v, vec_ptr w, data_t *dest);

  long int i;
  long long int time_sec, time_ns;
  long int MAXSIZE = BASE+(ITERS+1)*DELTA;

  // declare and initialize the vector structure
  vec_ptr v0 = new_vec(MAXSIZE);
  vec_ptr w0 = new_vec(MAXSIZE);
  data_holder = (data_t *) malloc(sizeof(data_t));
  init_vector(v0, MAXSIZE);
  init_vector(w0, MAXSIZE);

  for (i = 0; i < ITERS; i++) {
    set_vec_length(v0,BASE+(i+1)*DELTA);
    set_vec_length(w0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    dot(v0, w0, data_holder);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp[i] = diff(time1,time2);
  }

  for (i = 0; i < ITERS; i++) {
    set_vec_length(v0,BASE+(i+1)*DELTA);
    set_vec_length(w0,BASE+(i+1)*DELTA);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    dot_opt(v0, w0, data_holder);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    time_stamp_opt[i] = diff(time1,time2);
  }

  /* output times */
  for (i = 0; i < ITERS; i++) {
    printf("\n%d, ", BASE+(i+1)*DELTA);
    printf("%ld, ", cycles(&time_stamp[i])); 
    printf("%ld", cycles(&time_stamp_opt[i]));
  }

  printf("\n");
  
}/* end main */

/**********************************************/
/* Create vector of specified length */
vec_ptr new_vec(long int len)
{
  long int i;

  /* Allocate and declare header structure */
  vec_ptr result = (vec_ptr) malloc(sizeof(vec_rec));
  if (!result) return NULL;  /* Couldn't allocate storage */
  result->len = len;

  /* Allocate and declare array */
  if (len > 0) {
    data_t *data = (data_t *) calloc(len, sizeof(data_t));
    if (!data) {
	  free((void *) result);
	  return NULL;  /* Couldn't allocate storage */
	}
	result->data = data;
  }
  else result->data = NULL;

  return result;
}

/* Retrieve vector element and store at dest.
   Return 0 (out of bounds) or 1 (successful)
*/
int get_vec_element(vec_ptr v, long int index, data_t *dest)
{
  if (index < 0 || index >= v->len) return 0;
  *dest = v->data[index];
   return 1;
}

/* Return length of vector */
long int get_vec_length(vec_ptr v)
{
  return v->len;
}

/* Set length of vector */
int set_vec_length(vec_ptr v, long int index)
{
  v->len = index;
  return 1;
}

/* initialize vector */
int init_vector(vec_ptr v, long int len)
{
  long int i;

  if (len > 0) {
    v->len = len;
    for (i = 0; i < len; i++) v->data[i] = (data_t)(i);
    return 1;
  }
  else return 0;
}

data_t *get_vec_start(vec_ptr v)
{
  return v->data;
}

/*************************************************/
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

/*************************************************/
/* Combine1:  Implementation with maximum use of data abstraction */
void combine1(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);

  *dest = IDENT;
  for (i = 0; i < get_vec_length(v); i++) {
    data_t val;
    get_vec_element(v, i, &val);
    *dest = *dest OP val;
  }
}

/* Combine2:  Move call to vec_length out of loop 
 * Example of --> Code motion) */
void combine2(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  long int length = get_vec_length(v);

  *dest = IDENT;
   for (i = 0; i < length; i++) {
    data_t val;
    get_vec_element(v, i, &val);
    *dest = *dest OP val;
  }
}

/* Combine3:  Direct access to vector
 * Example of --> Reduce procedure calls */
void combine3(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);

  *dest = IDENT;
  for (i = 0; i < length; i++) {
    *dest = *dest OP data[i];
  }
}

/* Combine4:  Accumulate result in local variable
 * Example of --> Eliminate unneeded memory references */
void combine4(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v);
  data_t *data = get_vec_start(v);
  data_t acc = IDENT;

  for (i = 0; i < length; i++) {
    acc = acc OP data[i];
  }
  *dest = acc;
}

void dot(vec_ptr v, vec_ptr w, data_t *dest) {
   long int i;
   long int get_vec_length(vec_ptr v);
   data_t *get_vec_start(vec_ptr v);
   long int length = get_vec_length(v);
   data_t *vdata = get_vec_start(v);
   data_t *wdata = get_vec_start(w);
   data_t acc = IDENT;
   for (i = 0; i < length; i++) {
       acc = acc + vdata[i]*wdata[i];
   }
   *dest = acc;
}

void dot_opt(vec_ptr v, vec_ptr w, data_t *dest) {
    long int i;
    long int get_vec_length(vec_ptr v);
    data_t *get_vec_start(vec_ptr v);
    long int length = get_vec_length(v);
    data_t *vdata = get_vec_start(v);
    data_t *wdata = get_vec_start(w);
    long int limit = length - 18 + 1;
    data_t acc0 = IDENT;
    data_t acc1 = IDENT;
    data_t acc2 = IDENT;
    data_t acc3 = IDENT;
    data_t acc4 = IDENT;
    data_t acc5 = IDENT;
    for (i=0; i<limit; i+=18) {
        acc0 = acc0 + (vdata[i]*wdata[i] + (vdata[i+1]*wdata[i+1] + vdata[i+2]*wdata[i+2]));
        acc1 = acc1 + (vdata[i+3]*wdata[i+3] + (vdata[i+4]*wdata[i+4] + vdata[i+5]*wdata[i+5]));
        acc2 = acc2 + (vdata[i+6]*wdata[i+6] + (vdata[i+7]*wdata[i+7] + vdata[i+8]*wdata[i+8]));
        acc3 = acc3 + (vdata[i+9]*wdata[i+9] + (vdata[i+10]*wdata[i+10] + vdata[i+11]*wdata[i+11]));
        acc4 = acc4 + (vdata[i+12]*wdata[i+12] + (vdata[i+13]*wdata[i+13] + vdata[i+14]*wdata[i+14]));
        acc5 = acc5 + (vdata[i+15]*wdata[i+15] + (vdata[i+16]*wdata[i+16] + vdata[i+17]*wdata[i+17]));
    }
    limit = length - 6 + 1;
    for (; i<limit; i+=6) {
        acc0 = acc0 + vdata[i]*wdata[i];
        acc1 = acc1 + vdata[i+1]*wdata[i+1];
        acc2 = acc2 + vdata[i+2]*wdata[i+2];
        acc3 = acc3 + vdata[i+3]*wdata[i+3];
        acc4 = acc4 + vdata[i+4]*wdata[i+4];
        acc5 = acc5 + vdata[i+5]*wdata[i+5];
    }
    for (; i<length; i++) {
        acc0 = acc0 + vdata[i]*wdata[i];
    }
    *dest = acc0 + acc1 + acc2 + acc3 + acc4 + acc5;  
}

/* Combine5:  Unroll loop by 2
 * Example of --> Loop unrolling */
void combine5(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v);
  long int limit = length - 10 + 1;
  data_t *data = get_vec_start(v);
  data_t acc = IDENT;

  /* Combine two elements at a time */
  for (i = 0; i < limit; i+=10) {
    acc = (((((((((acc OP data[i]) OP data[i+1]) OP data[i+2]) OP data[i+3]) OP data[i+4]) OP data[i+5]) OP data[i+6]) OP data[i+7]) OP data[i+8]) OP data[i+9];
  }

  /* Finish remaining elements */
  for (; i < length; i++) {
    acc = acc OP data[i];
  }
  *dest = acc;
}

/* Combine6:  Unroll loop by 2, 2 accumulators
 * Example of --> parallelism */
void combine6(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v);
  long int limit = length - 10 + 1;
  data_t *data = get_vec_start(v);
  data_t acc0 = IDENT;
  data_t acc1 = IDENT;
  data_t acc2 = IDENT;
  data_t acc3 = IDENT;
  data_t acc4 = IDENT;
  data_t acc5 = IDENT;
  data_t acc6 = IDENT;
  data_t acc7 = IDENT;
  data_t acc8 = IDENT;
  data_t acc9 = IDENT;
  /* Combine two elements at a time w/ 2 acculators */
  for (i = 0; i < limit; i+=10) {
    acc0 = acc0 OP data[i];
    acc1 = acc1 OP data[i+1];
    acc2 = acc2 OP data[i+2];
    acc3 = acc3 OP data[i+3];
    acc4 = acc4 OP data[i+4];
    acc5 = acc5 OP data[i+5];
    acc6 = acc6 OP data[i+6];
    acc7 = acc7 OP data[i+7];
    acc8 = acc8 OP data[i+8];
    acc9 = acc9 OP data[i+9];
  }

  /* Finish remaining elements */
  for (; i < length; i++) {
    acc0 = acc0 OP data[i];
  }
  *dest = acc0 OP acc1 OP acc2 OP acc3 OP acc4 OP acc5 OP acc6 OP acc7 OP acc8 OP acc9;
}

/* Combine7:  Unroll loop by 2, change associativity
 * Example of --> parallelism */
void combine7(vec_ptr v, data_t *dest)
{
  long int i;
  long int get_vec_length(vec_ptr v);
  data_t *get_vec_start(vec_ptr v);
  long int length = get_vec_length(v);
  long int limit = length - 10 + 1;
  data_t *data = get_vec_start(v);
  data_t acc = IDENT;

  /* Combine two elements at a time */
  for (i = 0; i < limit; i+=10) {
    acc = acc OP (data[i] OP (data[i+1] OP (data[i+2] OP (data[i+3] OP (data[i+4] OP (data[i+5] OP (data[i+6] OP (data[i+7] OP (data[i+8] OP data[i+9])))))))));
  }

  /* Finish remaining elements */
  for (; i < length; i++) {
    acc = acc OP data[i];
  }
  *dest = acc;
}


