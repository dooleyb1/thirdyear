// Old code
void compute(int* array, int SIZE) {
  // Array is 16-byte unaligned address
  int i = 1;

  while(i<SIZE){
    array[i] = array[i] + array[i - 1];
    i = i+1
  }
}

// Vectorised code
N/A
