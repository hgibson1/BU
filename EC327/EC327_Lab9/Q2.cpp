//include headers and libraries
#include "Library.h"
#include <string>
#include <iostream>
using namespace std;

















int main(){
    Library library;
	cout << "Enter command: ";
	char command;
	string title;	
	cin >> command;
	while(command)
	{
		bool success;	
		if(command == 'a')
		{
			cin >> title;		
			success = library.addBook(title); 
			if(!success) cout << "Cannot add the book" << endl;


		}
		else if(command == 'r')
		{
			cin >> title;	
			success = library.removeBook(title);
			if(!success) cout << "Cannot remove the book" << endl;


		}
		else if(command == 'p')
		{
			cout << "Library contents: " << endl;
			library.print();


		}
		else if(command == 'q')
		{
			break;
		}
		cout << "Enter a command: ";
		cin >> command;		

	}
	return 0;
} 


