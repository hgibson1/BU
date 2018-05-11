#include "CuckooHashTable.h"
#include <iostream>
#include <fstream>
#include <string>
#include <cctype>

using namespace std;

int main(int argc, char** argv){

        ifstream input("input.txt");
	CuckooHashTable cht;
	string number = "";
	char next_letter = '\0';

	while (input.get(next_letter)){
		while (isdigit(next_letter) && !input.eof()){
			number += next_letter;
			input.get(next_letter);
		}
		cht.add(number);
		number = "";
	}

	cht.print();

	return 0;
}
