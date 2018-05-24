#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <math.h>

#define BASE 0
#define ITERS 200
#define DELTA 1
#define MAXSIZE BASE+(ITERS+1)*DELTA
#define XVAL 1.0
 
typedef double data_t;


inline long cycles(struct timespec *tm) {
    return (long) (tm->tv_sec*10e9 + tm->tv_nsec)*1.596;
}


typedef struct {
    long int len;
    data_t *data;
} vec_rec, *vec_ptr;

vec_ptr new_vec(long len) {
    vec_ptr result = (vec_ptr) malloc(sizeof(vec_rec));
    if (!result) {
        return NULL;
    }
    result->len = len;
    if (len > 0) {
        data_t *data = (data_t *) calloc(len, sizeof(data_t));
        if (!data) {
            free((void *) result);
            return NULL;
        }
        result->data = data;
    } else {
        result->data = NULL;
    }
    return result;
}

long get_vec_length(vec_ptr v) {
    return v->len;
}

void set_vec_length(vec_ptr v, long len) {
    v->len = len;
}

data_t * get_vec_start(vec_ptr v) {
    return v->data;
}

void init_vec(vec_ptr v, long len) {
    v->len = len;
    long i;
    for (i=0; i<=len; i++) {
        v->data[i] = (data_t) random()/RAND_MAX;
    }
}


main(int argc, char *argv) {
    //vec_ptr new_vec(long len);
    //vec_ptr init_vec(vec_ptr v, long len);
    //vec_ptr get_vec_length(vec_ptr v);
    //vec_ptr set_vec_length(vec_ptr v, long len); 
    data_t poly(vec_ptr coefs, data_t x, long degree);
    data_t poly_opt(vec_ptr coefs, data_t x, long degree);
    data_t polyh(vec_ptr coefs, data_t x, long degree);
    data_t polyh_opt(vec_ptr coefs, data_t x, long degree);   
    
    long i;
    struct timespec start, stop;
    vec_ptr coefs = new_vec(MAXSIZE);
    init_vec(coefs, MAXSIZE);
    long poly_cycl[ITERS], poly_opt_cycl[ITERS], polyh_cycl[ITERS], polyh_opt_cycl[ITERS];
    data_t poly_res[ITERS], poly_opt_res[ITERS], polyh_res[ITERS], polyh_opt_res[ITERS];
    
    for (i=0; i<ITERS; i++) {
        set_vec_length(coefs, BASE+(i+1)*DELTA);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
        poly_res[i] = poly(coefs, XVAL, get_vec_length(coefs));
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop);
        poly_cycl[i] = cycles(&stop) - cycles(&start);                   
    }

    for (i=0; i<ITERS; i++) {
        set_vec_length(coefs, BASE+(i+1)*DELTA);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
        poly_opt_res[i] = poly_opt(coefs, XVAL, get_vec_length(coefs));
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop);
        poly_opt_cycl[i] = cycles(&stop) - cycles(&start);
   }

   for (i=0; i<ITERS; i++) {
        set_vec_length(coefs, BASE+(i+1)*DELTA);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
        polyh_res[i] = polyh(coefs, XVAL, get_vec_length(coefs));
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop);
        polyh_cycl[i] = cycles(&stop) - cycles(&start);
   }

   for (i=0; i<ITERS; i++) {
        set_vec_length(coefs, BASE+(i+1)*DELTA);
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
        polyh_opt_res[i] = polyh_opt(coefs, XVAL, get_vec_length(coefs));
        clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &stop);
        polyh_opt_cycl[i] = cycles(&stop) - cycles(&start);
   }

   for (i=0; i<ITERS; i++) {
       printf("\n%d, %ld, %ld", BASE+(i+1)*DELTA, poly_cycl[i], poly_opt_cycl[i]);
   }   
   printf("\n");
}          


data_t poly(vec_ptr coefs, data_t x, long degree) {
    long i;
    data_t xpwr = x;
    data_t *data = get_vec_start(coefs);
    data_t result = data[0];
    for (i=1; i<=degree; i++) {
        result += data[i]*xpwr;
        xpwr = x*xpwr;
    }
    return result;
}


data_t poly_opt(vec_ptr coefs, data_t x, long degree) {
    long i;
    data_t *data = get_vec_start(coefs);
    data_t result0 = data[0];
    data_t result1 = 0.0;
    data_t result2 = 0.0;
    data_t result3 = 0.0;
    data_t result4 = 0.0;
    data_t result5 = 0.0;
    data_t result6 = 0.0;
    data_t result7 = 0.0;
    data_t xpwr = x;
    for (i=1; i<8; i++) {
        result0 += (data[i]*xpwr);
        xpwr *= x;
    }
    data_t limit = degree - 8 + 1;
    for (i=8; i<=limit; i+=8) {
        result0 += (data[i] * xpwr);
        result1 += (data[i+1] * xpwr);
        result2 += (data[i+2] * xpwr);
        result3 += (data[i+3] * xpwr);
        result4 += (data[i+4] * xpwr);
        result5 += (data[i+5] * xpwr);
        result6 += (data[i+6] * xpwr);
        result7 += (data[i+7] * xpwr);
        xpwr *= (x*(x*(x*(x*(x*(x*(x*x)))))));      
    }
    for (; i<=degree; i++) {
        result0 += (xpwr * data[i]);
        xpwr *= x;
    } 
    return result0 + result1 + result2 + result3 + result4 + result5 + result6 + result7;
}       


data_t polyh(vec_ptr coefs, data_t x, long degree) {
    long i;
    //data_t get_vec_start(v);
    data_t *data = get_vec_start(coefs);
    data_t result = data[0];
    for (i=degree-1; i>=0; i--) {
        result = data[i] + x*result;
    }
    return result;
}


data_t polyh_opt(vec_ptr coefs, data_t x, long degree) {
    return (data_t) 1;          
}
