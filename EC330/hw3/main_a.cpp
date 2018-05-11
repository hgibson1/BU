//
//  main.cpp
//  Linked_List
//

#include <iostream>
#include "LinkedList.h" //I changed this 

using namespace std;

int main(int argc, const char * argv[]) {
    
    LinkedList myList;
    
    cout << "Inserting: 5, 20, 7, -2\n";
    myList.add(5);
    myList.add(20);
    myList.add(7);
    myList.add(-2);
    
    cout << "The size of my list is " << myList.size() << endl;
    cout << "This is the content of my list: ";
    myList.print();
    
    cout << "Is 20 is in my list? " << (myList.contains(20) ? "yes" : "no") << endl;
    cout << "Is 10 is in my list? " << (myList.contains(10) ? "yes" : "no") << endl;

    cout << "Deleting: 20\n";
    myList.remove(20);
    
    cout << "This is the content of my list: ";
    myList.print();
    
    return 0;
}
