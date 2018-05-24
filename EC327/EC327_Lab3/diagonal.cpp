#include <string>
#include <iostream>
using namespace std;

int main()
{
int N;
int counter;
string space = "";
	while (N >=0 || N <=10){
	cout << "Enter an integer greater than zero and less than 10: ";
	cin >> N;
	if (N <=0 || N >=10){
	cout << "Invalid value for N" << endl;
	break;
	std::terminate;
	} else {
	for(int i=0; i<N; i++){
	counter = N - i;
		for (int j=0; j<i; j++){
		space = space + " ";	
		}
	cout << space << counter << endl;
	space = "";
	
	}
}
} 
}
	
