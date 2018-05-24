#ifndef USER_H
#define USER_H

#include <string>

using namespace std;

class User
{
  public:
    User(string name, int diskQuota);
    string getName() const;
    int getDiskQuota() const;
    int getAvailableQuota() const;
    virtual string getInfo() const;

    //returns false if not successful
    bool addData(int size);

    //returns false if not successful
    bool removeData(int size);
  private:
    string name;
    int diskQuota;
    int availableQuota;
};

#endif
