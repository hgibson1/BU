#include <iostream>
#include <string>

using namespace std;

string swapNthCase(const string & str, const int n);

//DO NOT MODIFY THE MAIN FUNCTION

int main(){
    //prompt for string
    string str;
    int n;
    cout << "Enter word: ";
    cin >> str;
    cout << "Enter N: ";
    cin >> n;
    //swap cases
    cout << "Swapped every Nth case: " << swapNthCase(str, n) << endl;

    return 0;
}

string swapNthCase(const string & str, const int n){
    //implement function here
	string newstring = str;

	for(int i=1; i<(newstring.length())/n + 1; i++)
	{
		char charAt = newstring[i*n-1];
			
		if(islower(charAt)) newstring.at(i*n-1) = toupper(charAt);
		else if(isupper(charAt)) newstring.at(i*n-1) = tolower(charAt);		
	}
	return newstring;

}
