// t3Test.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
//#include "stdafx.h"
//#include "t3.h"
#include <algorithm> // for using std::max
#include <time.h>




int calls =0;
int overflows = 0;
int underflows = 0;
int max_reg = 0;
int depth = 0;
int max_depth = 0;
int used_windows = 0;

void start() {
	calls++; // calculate the number of procedure calls
	depth++;
	if (depth > max_depth) {
		//std::cout << "if (depth > max_depth)\n";
		max_depth = depth;
	}
	if (used_windows >= max_reg) {
		//std::cout << "if (used_windows == max_reg\n";
		overflows++;
	}
	else {
		//std::cout << "else at entry\n";
		used_windows++;
	}
}

void end() {
	depth--;
	if (used_windows == 2) {   // always need 2 valid windows
		//std::cout << "if (used_windows == 2)\n";
		underflows++;
	}
	else {
		//std::cout << "else at exit\n";
		used_windows--;
	}
}

//not instrumented computePascal
int computePascal(int row, int position) {
	if (position == 1) {
		return 1;
	}
	else if (position == row) {
		return 1;
	}
	else {
		return computePascal(row - 1, position) + computePascal(row - 1, position - 1);
	}
}



int computePascal_instrumented(int row, int position) {
	//calls++; // calculate the number of procedure calls

	//if (overflows < max_reg - 1) overflows++; // calculate overflows

	//if (depth != max_reg ) depth++; // calculate overflows
	//else overflows++;
	int result = 0;

	start();
	
	if (position == 1) {
		result = 1;
	}
	else if (position == row) {
		result = 1;
	}
	else {
		result = computePascal_instrumented(row - 1, position) + computePascal_instrumented(row - 1, position - 1);
	}

	end();
	return result;
}


int main()
{
    std::cout << "Hello World!\n";



	std::cout << "max_reg = 6\n";
	max_reg = 6;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";

	std::cout << "max_reg = 8\n";
	calls = 0;
	overflows = 0;
	underflows = 0;
	depth = 0;
	max_depth = 0;
	max_reg = 8;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";

	std::cout << "max_reg = 16\n";
	calls = 0;
	overflows = 0;
	underflows = 0;
	depth = 0;
	max_depth = 0;
	max_reg = 16;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";






	std::cout << "Modify overflow\n";

	std::cout << "max_reg = 6\n";
	calls = 0;
	overflows = 0;
	underflows = 0;
	depth = 0;
	max_depth = 0;
	max_reg = 5;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";

	std::cout << "max_reg = 8\n";
	calls = 0;
	overflows = 0;
	underflows = 0;
	depth = 0;
	max_depth = 0;
	max_reg = 7;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";

	std::cout << "max_reg = 16\n";
	calls = 0;
	overflows = 0;
	underflows = 0;
	depth = 0;
	max_depth = 0;
	max_reg = 15;
	computePascal_instrumented(30, 20);
	std::cout << "number of call procedure: ";
	std::cout << calls << "\n";
	std::cout << "number of overflows: ";
	std::cout << overflows << "\n";
	std::cout << "number of underflows: ";
	std::cout << underflows << "\n";
	std::cout << "number of depth: ";
	std::cout << max_depth << "\n\n";

	
	//Q4
	// To measure the time of not instrumental computePascal(30, 20), clock_t with time.h is used in this programm
	clock_t start = clock();

	std::cout << "max_reg = 6 for calculating time\n";
	computePascal(30, 20);
	

	clock_t end = clock();

	const double time = static_cast<double>(end - start) / CLOCKS_PER_SEC * 1000.0;
	printf("time %lf[ms]\n", time);

	std::cout << "\n";
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



