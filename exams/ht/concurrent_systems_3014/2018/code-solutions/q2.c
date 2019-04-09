#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <assert.h>
#include <omp.h>
#include <math.h>
#include <stdint.h>
#include <x86intrin.h>

// Original c code (unoptimised)

void maximum(int depth, int width, int height, int matrix[depth][width][height]){

  // Initialise result 0th index as maximum
  int result[3] = {0, 0, 0};
  int curMax = 0.0;

  // Loop over array comparing max element
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      for(int k=0; k<depth; k++){

        // Do max comparsion here
        int val = matrix[i][j][k];

        // If new max, update
        if(val > curMax){
          curMax = val;
          result[0] = i;
          result[1] = j;
          result[2] = k;
        }
      }
    }
  }

  printf("\nMax: %d", curMax);
  printf("\nIndex: [%d][%d][%d]", result[0], result[1], result[2]);
  return;
}

// Open MP optimised code
void maximum2(int depth, int width, int height, int matrix[depth][width][height]){

  // Initialise result 0th index as maximum
  int result[3] = {0, 0, 0};
  int curMax = 0.0;
  int i,j,k;

  // Loop over array comparing max element
  #pragma omp parallel for private(i, j, k) shared(matrix, result, curMax) collapse(3) if(width * height * depth > 3000)
  for(int i=0; i<width; i++){
    for(int j=0; j<height; j++){
      for(int k=0; k<depth; k++){

        // Do max comparsion here
        int val = matrix[i][j][k];

        // If new max, update
        #pragma omp critical
        {
          if(val > curMax){
            curMax = val;
            result[0] = i;
            result[1] = j;
            result[2] = k;
          }
        }
      }
    }
  }

  printf("\n\nMax2: %d", curMax);
  printf("\nIndex2: [%d][%d][%d]", result[0], result[1], result[2]);
  return;
}

int main(int argc, char ** argv){

  // Declare array for max calculation
  int depth = 4;
  int width = 4;
  int height = 4;

  int arr[depth][width][height]=
        {
            {
              {11, 12, 13, 99},
              {14, 15, 16, 41},
              {17, 18, 19, 248},
              {17, 18, 19, 2432}
            },
            {
              {21, 22, 23, 139},
              {21, 22, 23, 139},
              {21, 22, 23, 131391},
              {21, 12342, 23, 139},
            },
            {
              {21, 22, 23, 139, 1920},
              {21, 22, 23, 139, 1020},
              {21, 22, 23, 139, 13324},
              {21, 22, 23, 139, 13324},
            },
            {
              {11, 12, 13, 99},
              {14, 15, 16, 41},
              {17, 18, 19, 248},
              {17, 18, 19, 2432}
            }
        };

    maximum(arr, depth, width, height);
    maximum2(arr, depth, width, height);
}
