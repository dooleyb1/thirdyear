// https://www.cs.virginia.edu/~cr4bd/3330/S2018/simdref.html

// Old code
void compute(float *array, int SIZE, float multiplier){
  for(int i = SIZE-1; i>=0; i--){
    array[i] = (array[i] * multiplier) / SIZE;
  }
}

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

// Other
void compute(float *array, int SIZE, float multiplier){

  int adjusted_size = SIZE;
  int is_overflow = 0;
  int overflow;

  // If size is not a multiple of 4, handle overflow
  if(SIZE % 4 != 0){
    overflow = SIZE % 4;
    adjusted_size = SIZE - overflow;
    is_overflow = 1;
  }

  for(int i=0; i<adjusted_size; i+=4){
    __m128 vector = _mm_load_ps(&array[i]);
    __m128 multiplier = _mm_set_ps1(multiplier)
    __m128 mul_result = _mm_mul_ps(vector, multiplier);
    __m128 divisor = _mm_set_ps1(SIZE);
    __m128 div_result = _mm_div_ps(mul_result, divisior);
    _mm_store_ps(array[i], div_result);
  }

  // Handle extra parts
  if(is_overflow){
    for(int i=0; i<overflow; i++){
      array[i] = (array[i] * multiplier) / SIZE;
    }
  }
}
