// ------------------------------------------------------------------------
//  2017 Q1 a) i
// ------------------------------------------------------------------------

// Old code
void compute(float *a, float* b){
  for(int i=0; i<1024; i++){
    b[i] = (1.0/(a[i]* a[i])) + 3.14159;
  }
}

// Vectorised code
void compute(float *a, float* b){
  // Increment for loop by 4 (vector with 4 floats)
  for(int i=0; i<1024; i+=4){
    // Load four floats starting at address a[i]
    __m128 a = _mm_load_ps(&a[i]);

    // Square each element in the vector
    __m128 a_squared = _mm_mul_ps(a, a);

    // Get the reciprocal of each element
    __m128 rcpr = _mm_rcp_ps(a_aquared);

    // Add 3.14159 to every element
    __m128 pi = _mm_set_ps1(3.14159);
    __m128 result = _mm_add_ps(rcpr, pi);

    // Store result into b[i]
    __mm_store_ps(&b[i], result);
  }
}
