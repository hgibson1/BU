//Define your two functions here using the same input parameters as given in the
//problem statement
#include "functions.h"
#include <cmath>
#include <iostream>
using namespace std;

//dot_product
float dot_product(float *a, float *b)
{
	//size is 3
	return a[0]*b[0] + a[1]*b[1] + a[2]*b[2];
	
}


float distance(float *a, float *b)
{
	double distance = pow((pow((a[0]-b[0]), 2) + pow((a[1]-b[1]), 2) + pow((a[2]-b[2]), 2)), 0.5); 
	return (float) distance;	
}
//dot_and_distance
void dot_and_distance(float *a, float *b, float* dot, float *distance_)
{
  *dot=dot_product(a, b);
  *distance_=distance(a, b);
}	

//contains all negative numbers
bool contains_only_negative_values(float *array)
{
	float negatives = 0;
	for(int i=0; i<3; i++){
		if(array[i]<0){
		negatives++;
		}
	}
	if(negatives > 2) return true;
	else return false;

}
