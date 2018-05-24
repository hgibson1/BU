#include <iostream>
#include "Admin.h"
#include "User.h"
#include <vector>
#include <cstdlib>
#include <sstream>
#include <string>
using namespace std;


//returns a pointer to a randomized User object
User* randUser()
{
	User* u;
	static int ID = 0;
	int quota = 5000 + rand() % 10000;
	stringstream ss;
	ss << ID++;

	string name = "name" + ss.str(); 
	if((rand() % 100) % 10 == 0){
		if(rand() % 2 == 0){
			u = new Admin(name, quota, true);
		} else {
			u = new Admin(name, quota);
		}
	} else {
		u = new User(name, quota);
	}
	u->addData(quota * rand()%256 / 256);
	return u;
}

void printUpdatedQuota(const User &u, int extendedQuota)
{
	cout << u.getInfo() << '\t'
	<< u.getDiskQuota() << '\t' <<  extendedQuota << endl;
}






int main()
{
	vector<User*> v;
	for(int i=0; i<100; i++)
	{
		v.push_back(randUser());
	}
	
	for(int j=0; j<100; j++)
	{
		
			Admin *admin = static_cast<Admin*>(v.at(j));
			if(admin != NULL)
			{	
				if(!admin->getIsRoot())	
				{	
					int quota = admin->getAvailableQuota(); 					 	
					printUpdatedQuota(*admin, quota);	
				}else{
					int quota = 4*(admin->getAvailableQuota());	
					printUpdatedQuota(*admin, quota);	
				}
			} else {
				int quota = 2*(v.at(j)->getAvailableQuota());	
				printUpdatedQuota(*(v.at(j)), quota);				
			}

		
		
	}	
	return 0;
} 
		 
			
		
		

		

