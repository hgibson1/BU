#include "Course.h"
#include <vector>
#include <string>
#include <iostream>

using namespace std;

Course::Course(int capacity)
{
    courseSize = 0;
    this->capacity = capacity;
//  students = vector<Student>(capacity);

}

Course::~Course()
{

	courseSize = 0;
	capacity = 0;
	
}

bool Course::addStudent(const string & name)
{
    //return false if the capacity is full
    if(courseSize == capacity){
        return false;
    } 
    Student student;
    student.name = name; 
    students.push_back(student);
    courseSize++;
    return true;
}

string Course::studentAt(int i) const
{
    if(i > courseSize){
        return "";
    } else {
        return students[i].name;
    }
}

int Course::indexOf(const string & name) const
{
    int index;
    for(index = 0; index < courseSize; index++){
        if(students[index].name == name){
            break;
        }
    }
    //if the student does not exist
    if(index == courseSize){
        index = -1;
    } 
    return index;
}

int Course::getCourseSize() const
{
    return courseSize;
}

int Course::getCapacity() const
{
    return capacity;
}

void Course::assignGrade(int i, int grade)
{
    //do not do anything if the index is wrong
    if(i >= courseSize || i < 0){
        return;
    }
    //assign grade
    students[i].grade = grade;
}

void Course::printGradeOf(int i) const
{
    //do not do anything if the index is wrong
    if(i >= courseSize || i < 0){
        return;
    }
    cout << students[i].grade;
}

Course::Course(const Course &course)
{
	this->capacity = course.getCapacity();
	this->courseSize = course.getCourseSize();


	for(int i = 0; i < course.getCourseSize(); i++)
	{
		Student student;
		student.name = course.studentAt(i);
		this->students.push_back(student);
	}
}
