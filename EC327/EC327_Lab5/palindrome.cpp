#include "palindrome.h"
#include  <string>
#include <iostream>
using namespace std;

bool isPalindrome(string word)
{string drow = "";
	for(int i = 0; i <= word.length()/2; i++)
	{
		if(word[i]!=word[word.length()-1-i])
		{
			return false;
		}
	}
	return true;
}	






















