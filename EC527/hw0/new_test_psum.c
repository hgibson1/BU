#include <stdio.h>
#include <time.h> 
#include <stdlib.h>


inline double nsecs_of_timeval(struct timespec * p_tv)
{
    return((double) p_tv->tv_sec) * 1e9 + ((double) p_tv->tv_nsec);
}


void psum1(float a[], float p[], long int n) {
    long int i;
    p[0] = a[0];
    for (i=1; i<n; i++) {
        p[i] = p[i-1] + a[i];
    }
}


void psum2(float a[], float p[], long int n) {
    long int i;
    p[0] = a[0];
    for (i=1; i<=n-1; i+=2) {
        float midpoint = p[i-1] + a[i];
        p[i] = midpoint;
        p[i+1] = midpoint + a[i+1];
    }
    if (i<n) p[i] = p[i-1] + a[i];
}


#define GHz 1.596
#define N 200
int main() {
    //Setup
    float a[N], p[N];
    int i;
    for (i=0; i<N; i++) {
        a[i] = (float) i;
    }
    
    //used for timing
    struct timespec start1, stop1, start2, stop2;
    for (i=0; i<=N; i+=50) {
        //psum1
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start1);
        psum1(a, p, i);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop1);
        
        //psum2
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start2);
        psum2(a, p, i);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop2);
     
        printf(
              "%d,%.0f,%.0f\n", 
              i, 
              ((nsecs_of_timeval(&stop1) - nsecs_of_timeval(&start1))*GHz),
              ((nsecs_of_timeval(&stop2) - nsecs_of_timeval(&start2))*GHz)
       );
    }
    return 0;
}

