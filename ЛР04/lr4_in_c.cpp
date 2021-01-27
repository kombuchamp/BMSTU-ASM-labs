#include <iostream>

using namespace std;

void print_out(int *iter, int N)
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			cout << *(iter) << " ";
			iter++;
		}
		cout << endl;
	}
	cout << endl;
}

int main()
{
	int arr[25] = { 1,2,3,4,5,
					1,2,3,4,5,
					1,2,3,4,5,
					1,2,3,4,5,
					1,2,3,4,5 };
	int N = 5;

	print_out(arr, N);

	int *first, *second;
	first = arr;
	second = arr;
    
    first += 1;
    second += N;
    
	for (auto i = 0; i < N - 1; i++)
	{
		for (int j = 0; j < N - 1 - i; j++)
		{
			swap<int>(*first, *second);
			first += 1;
			second += N;
		}
		first += (3 + i) - 1;
		second += (1 - N * (3 - i));
	}

	print_out(arr, N);

	return 0;
}