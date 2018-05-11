#include <iostream>
#include <fstream>
#include <queue>
#include <map>
#include <vector>
using namespace std;

/*INPUT FILE FORMAT IMPORTANT
N lines of N 1's or 0's not separated by anything
Each line ends with a newline character
NO space at the end of the line
NO spaces or other characters in between 1's and zeros
*/

int main() {
	ifstream input("maze.txt");
	
	//Determine N
	int N = 0;
	char ch;
	while (input.get(ch)) {
		if (ch == '\n') {
			break;
		}
		N++;
	}

	//Read in input into array
	//Space: Theta(V) = Theta(N^2)
	//Time: Theta(V)/Theta(N^2)
	input.clear();
	input.seekg(0, ios::beg);
	int maze[N * N];
	int nrow = 0;
	int ncol = 0;
	while (input.get(ch) && !input.eof()) {
		if (ch == '\n') {
			nrow++;
			ncol = 0;
		} else {
			maze[nrow * N + ncol] = (int) (ch - 48);
			ncol++;
		}			
	}

	//Build graph from input matrix, as adjacency list
	//Representation is a hashmap of vectors
	//Keys is matrix, value is vector of adjacent vertecies
	//Space: Theta(V), Theta(N^2)
	//Time to build: Theta(V), Theta(N^2)
	map<int, vector<int>> graph;
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			if (maze[i * N + j] == 1) {
				//If current index is 1 (a valid path)
				vector<int> neighbors;
				//four possible neighbors, test for each
				if (j != 0 && maze[i * N + j - 1] == 1) {
					//If not at left edge and neighbor to left is 1
					neighbors.push_back(i * N + j - 1);
				} 
				if (j != N - 1 && maze[i * N + j + 1] == 1) {
					//If not at right edge and neighbor to right is 1
					neighbors.push_back(i * N + j + 1);
				} 
				if (i != 0 && maze[(i - 1) * N + j] == 1) {
					//If not at top and neighbor above is 1
					neighbors.push_back((i - 1) * N + j);
				} 
				if (i != N - 1 && maze[(i + 1) * N + j] == 1) {
					//If not at bottom and neighbor below is 1 
					neighbors.push_back((i + 1) * N + j);
				} 
				graph.insert(pair<int, vector<int>>(i * N + j, neighbors));
			}
		}
	}

	//Find shortest Path using BFS search tree
	//Space = 2 * Theta(V)/Theta(N*N), except only 1 * Theta(V) in this case since reusing maze array
	//Time = Theta(V^3)/Theta(N^6) Number of edges per vertex is constant (>=4)
	//Set start and end indecies
	int start_index = 0;
	int end_index = N * N - 1;

	int index, next_index;
	map<int, vector<int>>::iterator vertex, next_vertex;
	deque<int> q; //Max size is V/N^2
	q.push_back(start_index);

	//Recycling maze space
	for (int i = 0; i < N*N; i++) {
		maze[i] = -1;
	}
	
	while(!q.empty()) { //Max is V, Theta(V)
		index = q.front();		
		q.pop_front();
		vertex = graph.find(index); //Max in graph is V, Theta(V) to search
		if (index == end_index) {
			break;
		}
		for (int i = 0; i < vertex->second.size(); i++) { //Max is 4, Theta(1)
				next_index = vertex->second[i];
				next_vertex = graph.find(next_index); //Max is V, Theta(V)
				if (next_vertex != graph.end() && maze[next_index] == -1 && next_index != start_index) {
					q.push_back(next_index);
					//cout << next_index << "\n";
					maze[next_index] = index;
				}
		}
	}

	//Print shortest path and calculate shortest path length
	//Constant space, Theta(V)/Theta(N^2) time	
	cout << "Shortest Path: ";
	int iter = end_index;
	int path_length = 0;
	while(iter != start_index && maze[iter] != -1) {
		cout << iter << " ";
		iter = maze[iter];
		path_length++;
	}
	cout << iter << "\n";
	cout << "Path Length: " << path_length << "\n";
	
	/*
	for (int i = 0; i < nrow; i++) {
		for (int j = 0; j < nrow; j++) {
			cout << maze[i * N + j];
		}
		cout << "\n";
	}
	*/
	/*
	map<int, vector<int>>::iterator iter;
	int length;
	for (iter = graph.begin(); iter != graph.end(); iter++) {
		cout << iter->first << ": ";
		length = iter->second.size();
		for (int i = 0; i < length; i++) {
			cout << iter->second[i] << " ";
		}
		cout << "\n";
	}
	*/

	return 0;
}
