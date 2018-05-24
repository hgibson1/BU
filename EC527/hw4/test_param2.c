/*************************************************************************/
// gcc -pthread -o test_param2 test_param2.c

#include <stdio.h>
#include <stdlib.h>

#include <pthread.h>

#define NUM_THREADS 10

typedef struct {
   int *array;
   int index;
} arg_vals;
/********************/

void *work(void *i)
{
  //int j, k;
  struct arg_vals f = *((arg_vals*)(i));  // get the value being pointed to
  struct arg_vals *g = (arg_vals*)(i);    // get the pointer itself
  
  //for (j; j < 10000000; j++) k += j;  // busy work
  //j = 0;
  //while (g[j] == 0 && j < NUM_THREADS) {
      //printf("\ng[j] = %d, j = %d", g[j], j);
      //j++;
  
  //printf("Counter %d", counter);  
  //g[counter] = counter;
  //counter++;
  (*g).data[(*g).index] = (*g).index;
  printf("\nHello World from %lu with value %d\n", pthread_self(), f);
  printf("\nHello World! %d  %d",  f, *g);

  pthread_exit(NULL);
}

/*************************************************************************/
int main(int argc, char *argv[])
{
  int arg,i,j,k,m;   	              /* Local variables. */
  pthread_t id[NUM_THREADS];
  int args[NUM_THREADS] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  struct arg_vals data;
  data.array = args;
  for (i = 0; i < NUM_THREADS; ++i) {
    data.index = i;
    if (pthread_create(&id[i], NULL, work, (void *) &data) {
      printf("ERROR creating the thread\n");
      exit(19);
    }
  }

  for (j; j < 100000000; j++) k += j;  // busy work

  printf("\nAfter creating the thread.  My id is %lu, i = %d\n",
	 pthread_self(), i);

  return(0);

}/* end main */


