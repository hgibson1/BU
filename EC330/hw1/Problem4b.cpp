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

string alphabetical(string str1, string str2) {
	int len = str2.length() > str1.length()? str2.length(): str1.length();
	char c1, c2;
	for (int i = 0; i < len; i++) {
		c1 = str1[i];
		c2 = str2[i];
		if (c2 < c1) {
			return str2;
		} else if (c1 < c2) {
			return str1;
		} 
	}
	return str1;
}

int MergeFiles(string filename1, string filename2) {
	ifstream infile1;
	infile1.open(filename1.c_str());
	ifstream infile2;
	infile2.open(filename2.c_str());
	if (!infile1.is_open()) {
		cout << "Couldn't open " << filename1 << "\n";
		return -1;
	}
	if (!infile2.is_open()) {
		cout << "Couldn't open " << filename2 << "\n";
		return -1;
	}
	ofstream outfile;
	outfile.open("output.txt");
	
	string str1;
	getline(infile1, str1);
	string str2;
	getline(infile2, str2);
	string temp = alphabetical(str1, str2);
	while (!temp.empty()) {
		cout << temp << " " << str1 << " " << str2 << "\n";
		outfile << temp << "\n";
		if (!temp.compare(str1)) {
			getline(infile1, str1);
		} else if (!temp.compare(str2)) {
			getline(infile2, str2);
		}
		temp = alphabetical(str1, str2);
	}

	infile1.close();
	infile2.close();
	outfile.close();
	return 0;
}

int main(int argc, char** argv) {
	if (argc != 3) {
		cout << "Usage ./Problem4b <file1> <file2>\n";
		return -1;
	}
	string filename1(argv[1]);
	string filename2(argv[2]);
	MergeFiles(filename1, filename2);
	return 0;
}
