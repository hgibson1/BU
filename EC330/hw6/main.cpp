#include "iostream"
#include "fstream"
using namespace std;

#include "problem4.h"


int main() {
	ifstream dictionary("dictionary.txt");
	if (!dictionary.is_open()) {
		cout << "Couldn't find dictionary file\n";
		exit(-1);
	}
	ifstream data("BigData.txt");
	if (!data.is_open()) {
		cout << "Couldn't find data file\n";
		exit(-1);
	}
	
	dictionary.close();
	data.close();

	return 0;
}
