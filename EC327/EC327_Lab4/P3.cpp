#include <string>
#include <cctype>
#include "tobinary.h"
#include <sstream>
#include <iostream>
using namespace std;

int main()
{int decimal = 0; int binary = 0; string input = "";
	cout << "Please Provide a non-negative integer " << endl;
	cin >> input;
	int i = 0; string value = "";
	while (i<input.length())
	{
		if(isdigit(input[i])==0)
		{	i = 0; value = "";
			cout << "Please Provide a non-negative integer " << endl;
			cin >> input;
			
		} else {
			value = value + input[i];
			i++;
		}
	}
	istringstream toInt(value);
	toInt >> decimal;
	cout << decimal << endl;
	string binaryString  = tobinary(decimal);
	istringstream toBinary(binaryString);
	toBinary >> binary;
	cout << binary <<endl;
	return 0;
}

