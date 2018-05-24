#include <string>
#include "User.h"
using namespace std;

class Admin : public User 
{
	private:
		bool isRoot;
	public:
		Admin(string name, int disk_quota, bool isRoot = false);
		bool getIsRoot() const;
		bool addData(int size);
		string getInfo() const;
};	
