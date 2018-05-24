#include <string>
#include "palindrome.h"
#include <iostream>
using namespace std;

bool containsNum(string word)
{
        for(int i=0; i<word.length(); i++)
        {
                if(word[i]=='1' || word[i]=='2' || word[i]=='3' ||
                word[i]=='4' || word[i]=='5' || word[i]=='6'||
                word[i]=='7' || word[i]=='8' || word[i]=='9')
                {
                        return true;
                }
        }
        return false;
}



int main()
{	string word;
	cout << "Enter a word" << endl;
	cin >> word;
	while(!containsNum(word))
	{
	if(isPalindrome(word))
	{
		cout << word << " is a palindrome" << endl;
	} else {
		cout << word <<  " is not a palindrome" << endl;
	}
	cout << "Enter a word" << endl;
	cin >> word;
}
	return 0;
}





















