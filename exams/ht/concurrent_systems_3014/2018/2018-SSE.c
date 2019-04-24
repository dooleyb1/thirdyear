// ------------------------------------------------------------------------
//  2018 Q1 b) i
// ------------------------------------------------------------------------

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

// This code cannot be vectorised with SSE intrinsics as there is an
// underlying dependency between array[i] and array[i+1] for every
// iteration of the while loop

// ------------------------------------------------------------------------
//  2018 Q1 b) ii
// ------------------------------------------------------------------------

// Old code
void compute(float *array, int SIZE, float multiplier){
  for(int i = SIZE-1; i>=0; i--){
    array[i] = (array[i] * multiplier) / SIZE;
  }
}

// Vectorised code
void compute(float *array, int SIZE, float multiplier){
  // Decrease i by 4 every time (performing 4 x 32-bit float operations per loop)
  for(int i = SIZE-1; i>=0; i-=4){
    // Load 4 x 32-bit floats into vector
    __m128 vector = _mm_load_ps(&array[i]);

    // Load multiplier into vector 4 times
    __m128 multiplier = _mm_set_ps1(multiplier)

    // Perform vector multiplication
    __m128 mul_result = _mm_mul_ps(vector, multiplier);

    // Load SIZE into vector 4 times
    __m128 divisor = _mm_set_ps1(SIZE);

    // Perform vector division
    __m128 div_result = _mm_div_ps(mul_result, divisior);

    // Store results back into array
    _mm_store_ps(array[i], div_result);
  }
}

// ------------------------------------------------------------------------
//  2018 Q1 b) iii
// ------------------------------------------------------------------------


// Old code
int compute(int* array, int SIZE){
  // Array is 16-byte aligned address
  int max = 0;

  for(int i=0; i<SIZE; i++){
    if(array[i] > max) {
      max = array[i];
    }
  }

  return max;
}

// Vectorised code
int compute(int* array, int SIZE){
  // Array is 16-byte aligned address
  int max;

  // Set max to [0, 0, 0, 0]
  __m128i maxval = _mm_setzero_si128();
  __m128i elements;

  // Reduce four loop by 4 (4 * 32-bit integers)
  for(int i=0; i<SIZE; i+=4){

    // Load 4 elements
    elements = _mm_load_si128(&array[i]);

    // Get vertical max result between vectors
    maxval = _mm_max_epi32(elements, maxval);
  }

  // Last step, find single maximum of resultant vector
  for (int i = 0; i < 3; i++) {
      maxval = _mm_max_epi32(maxval, _mm_shuffle_epi32(maxval, maxval, 0x93));
  }

  // Extract result from vector
  _mm_store_ss(&max, maxval);

  return max;
}

// ------------------------------------------------------------------------
//  2018 Q1 b) iv
// ------------------------------------------------------------------------

// http://shybovycha.tumblr.com/post/122400740651/speeding-up-algorithms-with-sse

// Old code
bool strcmp(char* string1, char* string2, int strlength){
  for(int i=0; i<strlength; i++{
    if(string1[i] != sting2[i]){
      return false
    }
  }
}

// Vectorised code
bool strcmp(char* string1, char* string2, int strlength){

  // Using SSE we can load 16 * 8-bit char's at a time
  for(int i=0; i<strlength; i+=16){

    // Load 16 chars from string1 and string2 into vectors
    __m128i string1Vector = _mm_load_si128((__m128i *) string1[i]);
    __m128i string2Vector = _mm_load_si128((__m128i *) string2[i]);

    // Compare vecotrs
    __m128i vcmp = _mm_cmpeq_epi8(string1Vector, string2Vector);

    // This function checks if NOT all equal
    if(!_mm_test_all_ones(vcmp){
      return false
    }
  }

  return true
}
