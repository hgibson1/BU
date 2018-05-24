#include "Course.h"
#include <string>
using namespace std;

class Physics : public Course
{
	private:
		int *labGrades;
		
	public:
		void assignGrade(int i, int grade, int labGrade);
		void printGradeOf(int i) const;
		~Physics();
		Physics(int capacity);
		string courseCode() const;
};
