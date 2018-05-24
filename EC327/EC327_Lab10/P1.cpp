#include <iostream>

#include "Admin.h"
#include "User.h"

using namespace std;


// DO NOT MODIFY THIS FILE


void display(User & u)
{
    cout << u.getInfo() << endl;
    cout << "Name: " << u.getName() << endl;
    cout << "Disk Quota: " << u.getDiskQuota() << endl;
    u.addData(1000);
    cout << "Available Quota: " << u.getAvailableQuota() << endl;
}

int main()
{
    User u1("Student1", 10000);
    User u2("Student2", 500);
    Admin a1("TheITguy", 50000);
    Admin a2("System", 10000, true);
    display(u1);
    cout << "---\n";
    display(u2);
    cout << "---\n";
    display(a1);
    cout << "---\n";
    display(a2);
    cout << "---\n";
}
