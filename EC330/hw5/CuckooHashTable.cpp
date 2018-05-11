#include <string>
#include <vector>
#include <iostream>
#include <cstdlib>
using namespace std;

#include "CuckooHashTable.h"

#define LOOP_LIMIT 20

CuckooHashTable::CuckooHashTable() {
	currentSize = 2;
	contents = vector<vector<string>>();
	vector<string> table0 = vector<string>();
	vector<string> table1 = vector<string>();
	for (int i = 0; i < LOGICAL_SIZE; i++) {
		table0.push_back("");
		table1.push_back("");
	}
	contents.push_back(table0);
	contents.push_back(table1);
}

int CuckooHashTable::hashCode(string value, int which) {
	int sum = strtol(value.c_str(), NULL, 10);
	if (which == 0) {
		return sum % 13;
	} else if (which == 1) {
		return 11 - (sum % 11);
	} else {
		return -1;
	}
}

void CuckooHashTable::add(string value) {
	int counter = 0;
	int hashCode0 = hashCode(value, 0);
	int hashCode1;
 
	while(counter < LOOP_LIMIT) {
		if (contents[0][hashCode0] == "") {
			contents[0][hashCode0] = value;
			return;
		}
		hashCode1 = hashCode(contents[0][hashCode0], 1);
		if (contents[1][hashCode1] == "") {
			contents[1][hashCode1] = contents[0][hashCode0];
			contents[0][hashCode0] = value;
			return;
		}
		hashCode0 = hashCode(contents[1][hashCode1], 0);
		counter++;	
	}
	cout << "Error, cuckoo hash infinite loop\n";
	exit(-1);
}

void CuckooHashTable::print() {
	for (int i = 0; i < currentSize; i++) {
		cout << "Table " << i << ":\n";
		for (int j = 0; j < LOGICAL_SIZE; j++) {
			cout << "\t";
			if (contents[i][j] == "") {
				cout << "-";
			} else {
				cout << contents[i][j];
			}
			cout << "\n";
		}
	}
}

