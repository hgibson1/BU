#include "Admin.h"
#include <string>

Admin::Admin(string name, int diskQuota, bool isRoot):User(name, diskQuota) 
{
	this->isRoot = isRoot;
}




bool Admin::getIsRoot() const
{
	return isRoot;
}

bool Admin::addData(int size) 
{
	if(isRoot) return true;
	else return User::addData(size);
}

string Admin::getInfo() const
{
	return string("Admin");
} 
