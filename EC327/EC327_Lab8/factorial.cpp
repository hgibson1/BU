#include <iostream>

using namespace std;

int main()
{
    double num;
   double fact = 1; 
	cout << "*Factorial Finder*" << endl;
    cout << "Please enter a number:";
    cin >> num;
    if(num >= 0){ //compute factorial only for positive numbers
        
        for(int i = 2; i <= num; i++){
            fact *= i;
        }
    } else {
        cout << "You entered a negative number!" << endl;
    }
    cout << "The factorial of " << num << " is " << fact << "." << endl;
    return 0;
}
