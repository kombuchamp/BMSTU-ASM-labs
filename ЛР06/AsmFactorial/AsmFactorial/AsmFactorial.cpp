// AsmFactorial.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <iostream>

extern "C" void factorial(int N, int *result);

void c_factorial(int N, int *result)
{
	if (N <= 1)
		return;
	*result = *result * N;
	c_factorial(N - 1, result);
}


int main()
{
	int res = 1, n = 5;
	factorial(n, &res); 
    std::cout << "!" << n << " = " << res << std::endl;
	system("echo.");
	system("pause");
}
