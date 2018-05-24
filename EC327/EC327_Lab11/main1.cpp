#include <iostream>
#include "Course.h"


//DO NOT MODIFY THIS FILE


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
    Course history(120);
    history.addStudent("Clark Kent");
    history.addStudent("Bruce Wayne");
    history.addStudent("Mary Jane");
    history.assignGrade(history.indexOf("Clark Kent"), 80);
    history.assignGrade(history.indexOf("Bruce Wayne"), 80);
    history.assignGrade(history.indexOf("Mary Jane"), 90);

    //create a math class using the students in history
    Course math(history);
    math.assignGrade(math.indexOf("Clark Kent"), 100);
    math.assignGrade(math.indexOf("Bruce Wayne"), 90);
    math.assignGrade(math.indexOf("Mary Jane"), 75);
    //add one more student and assign grade
    math.addStudent("John Smith");
    math.assignGrade(math.indexOf("John Smith"), 70);

    //print students and grades for both courses
    cout << "History:" << endl;
    printGrades(history);

    cout << "Math:" << endl;
    printGrades(math);

    return 0;
}
