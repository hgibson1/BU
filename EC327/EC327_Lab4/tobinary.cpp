#include "tobinary.h"
#include <sstream>
#include <string>
using namespace std;

string tobinary(int decimal)
{	string bin;
	if (decimal%2)
	{
		bin = "1";
	}else{
		bin = "0";
	}
	if(decimal<2)
	{
		return bin;
	}else{
		return tobinary(decimal/2) + bin;
	}
}

