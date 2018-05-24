#include "computeSeries.h"


double computeSeries(int n)
{
	if(n==1)
	{
		return (double) 1;
	}else{
		return (double) 1/n + computeSeries(n-1);
	}
}

































