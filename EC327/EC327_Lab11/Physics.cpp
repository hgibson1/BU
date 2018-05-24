#include "Physics.h"
#include <string>
#include <iostream>
using namespace std;

Physics::Physics(int capacity) : Course(capacity) 
{


	this->labGrades = new int[capacity];
}

Physics::~Physics()
{


	delete [] this->labGrades;
}

void Physics::assignGrade(int i, int grade, int labGrade)
{
	Course::assignGrade(i, grade);
	this->labGrades[i] = labGrade;
}

void Physics::printGradeOf(int i) const
{
	Course::printGradeOf(i);
	cout << labGrades[i];
}

string Physics::courseCode() const
{
	return "Physics";
}


	
