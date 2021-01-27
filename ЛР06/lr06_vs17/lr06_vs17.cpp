#include "pch.h"
#include <iostream>

extern "C" void factorial(int N, int *result);

void function(int N, int *result)
{
	if (N <= 1)
		return;
	*result = *result * N;
	function(N - 1, result);
}


int main()
{
	int res = 1, n = 5;
	//function(5, &res);
	factorial(n, &res); 
    std::cout << "!" << n << " = " << res << std::endl;
}
