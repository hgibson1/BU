#include <string>
#include <fstream>
#include <iostream>
#include <stdlib.h>
#include "MaxProduct.h"
using namespace std;

long MaxProductClass::MaxProduct(string file) {
	ifstream infile;
	infile.open(file.c_str());
	
	long product = 1;
	long subproduct3 = 1;
	long subproduct2 = 1;
	long subproduct1 = 1;
	long max_product = 1;
	
	char c;
	string numstr = "";
	long num;
	long window[3] = {1, 1, 1};
	
	while(!infile.eof()) {
		c = infile.get();
		if (c == ' ' || c == '\n') {
			num = atol(numstr.c_str());
			if (num == -999999) {
				cout << product << endl;
				if (product > max_product) {
					max_product = product;
				}
				product = 1;
				window[0] = 1;
				window[1] = 1;
				window[2] = 1;
			} else {
				window[2] = window[1];
				window[1] = window[0];
				window[0] = num;
				subproduct3 = window[0] * window[1] * window[2];
				subproduct2 = window[0] * window[1];
				subproduct1 = window[1];
				if (subproduct3 > product && subproduct3 > subproduct2 && subproduct3 > subproduct1 || product == 1) {
					product = subproduct3;
				} else if (subproduct2 > product && subproduct2 > subproduct3 && subproduct2 > subproduct1) {
					product = subproduct2;
				} else if (subproduct1 > product && subproduct1 > subproduct3 && subproduct2 > subproduct1) {
					product = subproduct1;
				}
					
			}
			numstr = "";
		} else {
			numstr = numstr + c;
		} 	
	}
	
	infile.close();	
	return max_product;
}

