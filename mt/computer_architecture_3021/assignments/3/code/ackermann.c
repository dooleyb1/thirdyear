// Ackermann's Function - Full Recursive
// Sampled from https://gist.github.com/justjkk/407739

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define MAX_WINDOWS 16

// Function declarations
int ackermann(int x, int y, int depth);

// Initialise variables
int depth = 0;
int maxDepth = 0;
int overflowCount = 0;
int underflowCount = 0;
int windowsUsed = 0;
int callCount = 0;

int main(int argc, char **argv) {

	int x,y;

	x=atoi(argv[1]);
	y=atoi(argv[2]);

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
    BS += ackermann(3, 6, 0);
  }

  // Stop clock
  endTime = clock();

  // Calculate elapsed time
  unsigned long elapsedTime = endTime - startTime;
  elapsedTime = elapsedTime / (i + 1);

	printf("\nAckermann Function with inputs (%d,%d) is %d\n", x, y, BS);
	printf("\nFunction called %d times.\n", callCount);
  printf("\nOverflow occurred %d times.\n", overflowCount);
  printf("\nUnderflow occurred %d times.\n", underflowCount);
  printf("\nMax depth %d.\n", maxDepth);


  return 0;
}

int ackermann(int x, int y, int depth) {

  depth++;
  callCount++;

  // Check for overflow
  if(depth > maxDepth){
    maxDepth = depth;
  }

  // Check windows for overflows
  if(windowsUsed == MAX_WINDOWS){
    overflowCount++;
  } else{
    windowsUsed++;
  }

  if (x == 0) {

    depth--;

    // Check windows for underflows
    if(windowsUsed == 2){
      underflowCount++;
    } else{
      windowsUsed--;
    }

    return y+1;
  }

  else if (y == 0) {
    return ackermann(x-1, 1, depth+1);
  }

  else {
    return ackermann(x-1, ackermann(x, y-1, depth+1), depth+1);
  }
}
