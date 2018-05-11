#include <iostream>
#include <fstream>
#include <string>
#include <stdlib.h>
#include <vector>
#include <map>
#include "points.h"
using namespace std;

int main() {
	ifstream input;
	input.open("input.txt");
	string numstr = "";
	char c = input.get();
	
	numstr = numstr + c;
	const int numpoints = atol(numstr.c_str());
	input.get();

	int iterator = 0;
	float xpoints[numpoints];
	float ypoints[numpoints];
	numstr = "";
	while (!input.eof()) {
		c = input.get();
		if (c == '\n') {
			ypoints[iterator] = atol(numstr.c_str());
			iterator++;
			numstr = "";
		} else if (c == ' ') {
			xpoints[iterator] = atol(numstr.c_str());
			numstr = "";
		} else {
			numstr = numstr + c;
		}		
	}
	input.close();

	points(xpoints, ypoints, numpoints);
	
	map<pair<float, float>, vector<int>> lines = points(xpoints, ypoints, numpoints);
	map<pair<float, float>, vector<int>>::iterator iter;
	vector<int> indecies;
	pair<float, float> line;
	int length; 
	for (iter = lines.begin(); iter != lines.end(); iter++) {
		line = iter->first;
		indecies = iter->second;
		length = indecies.size();
		if (length >= 4) {
			cout << "M=" << line.first << " Intercept=" << line.second << "\n";
			for (int j = 0; j < length; j++) {
				cout << "(" << xpoints[indecies[j]] << "," << ypoints[indecies[j]] << ")\n";
			}
			cout << "\n";
		} 
	}	
	
	return 0;
}
