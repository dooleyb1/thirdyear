// Ackermann's Function - Full Recursive
// Sampled from https://gist.github.com/justjkk/407739

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

// Function declarations
int ackermann(int x, int y);

// Initialise variables
int depth = 1;
int maxWindows = 0;
int maxDepth = 0;
int overflowCount = 0;
int underflowCount = 0;
int windowsUsed = 2;
int callCount = 0;

int main(int argc, char **argv) {

	int x,y;

	if(argc!=4)
	{
		printf("\nUsage : %s <number1> <number2> <max_windows>\n",argv[0]);
		exit(0);
	}

	x=atoi(argv[1]);
	y=atoi(argv[2]);
	maxWindows=atoi(argv[3]);

  unsigned long microSeconds = 0;
  float milliSeconds = 0.0;

  // Clock time structs
  clock_t startTime, endTime;

  // Start clock
  startTime = clock();

  int BS = 0;
  int i;

  // Run Ackermann(3,6)
  for(i = 0; i < 1; i++){
    BS += ackermann(3, 6);
  }

  // Stop clock
  endTime = clock();

  // Calculate elapsed time
	double elapsed = (double)(endTime - startTime) * 1000.0 / CLOCKS_PER_SEC;

	printf("\nAckermann Function with inputs (%d,%d) and maxWindows (%d) is %d\n", x, y, maxWindows, BS);
	printf("\nFunction called %d times.\n", callCount);
  printf("\nOverflow occurred %d times.\n", overflowCount);
  printf("\nUnderflow occurred %d times.\n", underflowCount);
  printf("\nMax depth %d\n", maxDepth);
	printf("\nTime elapsed in ms: %lf\n", elapsed);

  return 0;
}

int ackermann(int x, int y) {

  callCount++;

  // Check for overflow
  if(depth > maxDepth){
    maxDepth = depth;
  }

	// Exit point here
  if (x == 0) {
    return y+1;
  }

	// Entry point one
  else if (y == 0) {

		depth++;

		// Check windows for overflows
	  if(windowsUsed == maxWindows){
	    overflowCount++;
	  } else{
	    windowsUsed++;
	  }

		// Catch ackermann value first
    int val = ackermann(x-1, 1);

		depth--;

		// Check windows for underflows
		if(windowsUsed == 2){
			underflowCount++;
		} else{
			windowsUsed--;
		}

		return val;
  }

	// Entry point two
  else {

		depth++;

		// Check windows for overflows
	  if(windowsUsed == maxWindows){
	    overflowCount++;
	  } else{
	    windowsUsed++;
	  }

	  int val = ackermann(x-1, ackermann(x, y-1));

		depth--;

		// Check windows for underflows
		if(windowsUsed == 2){
			underflowCount++;
		} else{
			windowsUsed--;
		}

		return val;
  }
}
