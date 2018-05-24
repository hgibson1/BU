#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

char* buffer = new char[100];

int getFibonacci(int index){
    int previous = 0;
    int current = 1;
    if(index == 1){
        return 0;
    }
    if(index == 7) { //the 7th fibonacci numbers 8
        cout << "The result is 8!" << endl;
        *buffer = '8';
    }
    for(int i = 2; i < index; i++){
        int temp = current;
        current += previous;
        previous = temp;
    }
    return current;
}

void printFibonacci(){
    char line[100];
    cout << "Please enter a number:" << endl;
    cin >> line;
    int fibonacci = getFibonacci(atoi(line));
    strcpy(buffer, to_string((long long)fibonacci).c_str());
    cout << buffer << endl;
}

int main(int argv, char** argc){
    printFibonacci();
    return 0;
}
