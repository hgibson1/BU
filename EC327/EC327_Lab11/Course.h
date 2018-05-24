#ifndef COURSE_H
#define COURSE_H
#include <vector>
#include <string>

using namespace std;

class Student
{
	public:
	string name;
	int grade;
};

class Course
{
public:
    Course(int capacity);

    //destructor
    ~Course();

    //adds student & returns true
    //returns false if the capacity is full
    bool addStudent(const string & name);

    //returns the name of the i'th student
    //if index > size, returns empty string
    string studentAt(int i) const;

    //returns the index of the student
    //returns -1 if the student does not exist
    int indexOf(const string & name) const;

    //returns course size
    int getCourseSize() const;

    //returns maximum course capacity
    int getCapacity() const;

    //assigns a grade to the i'th student
    void assignGrade(int i, int grade);

    //print the grade of the i'th student
    void printGradeOf(int i) const;

    //returns the course code
    string courseCode();
	
    Course(const Course &course);



private:

    int courseSize;
    int capacity;
    vector<Student> students;
};






 

#endif
