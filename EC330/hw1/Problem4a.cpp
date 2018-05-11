/*
Will compile with:
g++ -std=c++11 <files>

or
gcc -std=c++11 <files> -lstdc++
*/

#include <string>
#include <iostream>
#include <fstream>
using namespace std;

int StringSearch(string filename, string pattern) {
	string text;
	ifstream infile;
	infile.open(filename.c_str(), ios::in);
	if (!infile.is_open()) {
		cout << "Couldn't open file " << filename << "\n";
		return -1;
	}
	int position;
	int result = 0;
	while(getline(infile, text)) {
		//cout << text << "\n";
		position = text.find(pattern, 0);
		while(position != string::npos) {
			result++;
			position = text.find(pattern, position+1);
		}	
	}
	infile.close(); 
	return result;
}


int main(int argc, char** argv) {
	if (argc != 3) {
		cout << "Usage: Problem4a <filename> <pattern>\n";
		return -1;
	}
	
	string filename (argv[1]);
	cout << "Filename: " << filename << "\n";
	string pattern (argv[2]);
	cout << "Pattern: " << pattern << "\n";
	int result = StringSearch(filename, pattern);
	cout << "Instances of Pattern: " << result << "\n";	
	return 0;
}

