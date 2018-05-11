#include <algorithm>
#include <vector>
#include <map>
#include "points.h"
using namespace std;

map<pair<float, float>, vector<int>> points(float* xpoints, float* ypoints, const int numpoints) {
	float x, y, m, intercept;
	map<pair<float, float>, vector<int>> slopes;
	map<pair<float, float>, vector<int>>::iterator iter;
	pair<float, float> line;

	//Create data structure 
	//Map with 2 keys, the slope and y-intercept, 1 entry per line
	//Number of lines = k
	//Asymptotic Complexity is Omega(n^2*k)
	//Worst case: every point is in their own line: Omega(n^3)
	//Best case: all points are in the same line: Omega(n^2)
	//Performace depends on input data
	for (int i = 0; i < numpoints - 1; i++) {
		x = xpoints[i];
		y = ypoints[i];
		for (int j = i + 1; j < numpoints; j++) {
			m = (ypoints[j] - y)/(xpoints[j] - x);
			intercept = m * (-xpoints[j]) + ypoints[j];
			line = pair<float, float>(m, intercept);
			iter = slopes.find(line);
			if (iter == slopes.end()) {
				iter = slopes.begin();
				vector<int> points;
				points.push_back(i);
				points.push_back(j);
				slopes.insert(iter, pair<pair<float, float>, vector<int>>(line, points));
			} else {
				iter->second.push_back(j);		
			}
		}
	}
	
	//Remove duplicate points from each vector of data structure
	//Number of points per vector = p
	//Complexity: Omega(k * (p*log(p) + p))
	//When each point in own line is Omega(n * constant)
	//When all points in 1 line is Omega(nlog(n))
	vector<int> points;
        for (iter = slopes.begin(); iter != slopes.end(); iter++) {
		points = iter->second;
		sort(points.begin(), points.end());
		points.erase(unique(points.begin(), points.end()), points.end());
		iter->second = points;
        }       

	return slopes;
}

