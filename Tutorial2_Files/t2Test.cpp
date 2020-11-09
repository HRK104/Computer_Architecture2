// t2Test.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
//#include "stdafx.h"
#include "t2.h"
#include <algorithm> // for using std::max

_int64 fib(_int64 n) {
	if (n <= 1)
		return n;
	else
		return fib(n - 1) + fib(n - 2);
}

//
// check
//
void check(const char *s, _int64 v, _int64 expected) {
	std::cout << s << " = " << v;
	if (v == expected) {
		std::cout << " OK";
	}
	else {
		std::cout << " ERROR: should be " << expected;
	}
	std::cout << "\n";
}

int main()
{
	std::cout << "Hello World!\n";
	//Evaluating the procedures
	//
	// t2
	//


	/*_int64 array_int64[5] = { 1,2,3,4,5 };
	_int64 array_size = 5;
	std::cout << "Array: ";
	for (int i = 0; i < array_size; i++) {
		std::cout << array_int64[i] << " ";
	}
	std::cout << "\n";

	std::cout << "Sum: " << array_proc(array_size, array_int64) << "\n";*/

	

	// Fibonacci Series
	std::cout << "Fibonacci Series: " << "\n";
	for (int i = -1; i < 20; ++i)
		std::cout << fib(i) << " ";
	std::cout << "\n";

	std::cout << "Fibonacci Series by assembly: " << "\n";
	for (int i = -1; i < 20; ++i)
		std::cout << fibX64(i) << " ";
	std::cout << "\n\n";

	// use_scanf
	_int64 sum_scanf;
	_int64 sum_check;
	
	sum_scanf = use_scanf(1, 2, 3);
	sum_check = 1 + 2 + 3 + inp_int;
	check("use_scanf(1,2,3)", sum_scanf, sum_check);
	std::cout << "\n";
	sum_scanf = use_scanf(-3, 2, -2);
	sum_check = -3 + 2 - 2 + inp_int;
	check("use_scanf(-3,2,-2)", sum_scanf, sum_check);
	std::cout << "\n";
	sum_scanf = use_scanf(4, 3, -4);
	sum_check = 4 + 3 - 4 + inp_int;
	check("use_scanf(4,3,-4)", sum_scanf, sum_check);
	std::cout << "\n";
	sum_scanf = use_scanf(-3, -3, -4);
	sum_check = -3 - 3 - 4 + inp_int;
	check("use_scanf(-3,-3,-4)", sum_scanf, sum_check);

	std::cout << "\n\n";

	// max5
	std::cout << "Global variable (inp_int): " << inp_int << "\n";
	check("max5(1, 2, 3, 4)", max5(1, 2, 3, 4), std::max(std::max(std::max(std::max(inp_int, (long long)1), (long long)2), (long long)3), (long long)4));
	check("max5(3, 1, 2, 5)", max5(3, 1, 2, 5), std::max(std::max(std::max(std::max(inp_int, (long long)3), (long long)1), (long long)2), (long long)5));
	check("max5(2, 3, 1, -5)", max5(2, 3, 1, -5), std::max(std::max(std::max(std::max(inp_int, (long long)2), (long long)3), (long long)1), (long long)-5));
	check("max5(-1, -2, -3, -4)", max5(-1, -2, -3, -4), std::max(std::max(std::max(std::max(inp_int, (long long)-1), (long long)-2), (long long)-3), (long long)-4));
	check("max5(-3, -1, -2, 0)", max5(-3, -1, -2, 0), std::max(std::max(std::max(std::max(inp_int, (long long)-3), (long long)-1), (long long)-2), (long long)0));
	check("max5(-2, -3, -1, 3)", max5(-2, -3, -1, 3), std::max(std::max(std::max(std::max(inp_int, (long long)-2), (long long)-3), (long long)-1), (long long)3));
	check("max5(-1, 2, 3, 4)", max5(-1, 2, 3, 4), std::max(std::max(std::max(std::max(inp_int, (long long)-1), (long long)2), (long long)3), (long long)4));
	check("max5(3, -1, 2, 6)", max5(3, -1, 2, 6), std::max(std::max(std::max(std::max(inp_int, (long long)3), (long long)-1), (long long)2), (long long)6));
	check("max5(2, 3, -1, -5)", max5(2, 3, -1, -5), std::max(std::max(std::max(std::max(inp_int, (long long)2), (long long)3), (long long)-1), (long long)-5));

	std::cout << "\n";
	// Sum of array through assembly
	_int64 array_int64[5] = { 1,2,3,4,5 };
	_int64 array_size = 5;
	std::cout << "Array: ";
	for (int i = 0; i < array_size; i++)
		std::cout << array_int64[i] << " ";

	std::cout << "\n";

	std::cout << "Sum: " << array_proc(array_size, array_int64) << "\n";

	// Sum of two 64-bit integers
	long long i = 10;
	_int64 j = 20;
	_int64 sum = print_proc(i, j);

	std::cout << "Sum returned by print_proc: " << sum << "\n";


	// Code to clear the newline from the buffer and having to wait before exiting
	int c;
	do {
		c = getchar();
	} while (c != '\n' && c != EOF);
	if (c == EOF) {
		// input stream ended, do something about it, exit perhaps
	}
	else {
		printf("Type Enter to continue\n");
		getchar();
	}

	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
