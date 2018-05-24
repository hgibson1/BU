#include <iostream>
#include "Physics.h"


// DO NOT MODIFY THIS FILE


void printGrades(const Course & course)
{
    for(int i = 0; i < course.getCourseSize(); i++){
        cout << course.studentAt(i) << " - ";
        course.printGradeOf(i);
        cout << endl;
    }
    cout << endl;
}

int main()
{
    Physics physics(120);
    physics.addStudent("John Smith");
    physics.addStudent("Bruce Wayne");
    physics.assignGrade(physics.indexOf("John Smith"), 50, 70);
    physics.assignGrade(physics.indexOf("Bruce Wayne"), 70, 50);

    printGrades(physics);

    return 0;
}
