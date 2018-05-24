#include "User.h"

using namespace std;


// DO NOT MODIFY THIS FILE


User::User(string name, int diskQuota)
{
    this->name = name;
    this->diskQuota = diskQuota;
    availableQuota = diskQuota;
}

string User::getName() const
{
    return name;
}

int User::getDiskQuota() const
{
    return diskQuota;
}

int User::getAvailableQuota() const
{
    return availableQuota;
}

string User::getInfo() const
{
    return string("User");
}

bool User::addData(int size)
{
    if(availableQuota < size){
        return false;
    } else {
        availableQuota -= size;
        return true;
    }
}

bool User::removeData(int size)
{
    int usedDisk = diskQuota - availableQuota;
    if(usedDisk < size){
        return false;
    } else {
        availableQuota += size;
        return true;
    }
}
