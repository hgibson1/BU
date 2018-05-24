#include "functions.h"
#include <cmath>
#include <iostream>
using namespace std;

int main()
{
	float dot, distance;
	float a[3]; float b[3];
	cout<<"Enter 3 numbers: ";
	cin >> a[0] >> a[1] >> a[2];
	cout << "Enter another set of 3 numbers: ";
	cin >> b[0] >> b[1] >> b[2];
	while(!contains_only_negative_values(a) && !contains_only_negative_values(b))
	{
		
	
		dot_and_distance(a,b, &dot, &distance);
		cout << "Enter 3 numbers: ";
		cin >> a[0] >> a[1] >> a[2];
		cout << "Enter another set of 3 numbers: ";
		cin >> b[0] >> b[1] >> b[2];
	}
	cout << "All three numbers in an array cannot be negative" << endl;
	return 0;
}	













