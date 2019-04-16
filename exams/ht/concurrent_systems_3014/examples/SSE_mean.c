#include <xmmintrin.h>

/*
 *  Function to calculate maximum values between two vector lanes
 *
*/
__m128 mean(float *a, int size){

  // sum4 = 0
  __m128 sum4 = _mm_zero_ps();
  float result;

  // Step over all vector lanes adding them to sum
  for(int i=0; i< size; i+=4){
    __m128 a4 = _mm_loadu_ps(&a[i]);
    sum4 = _mm_add_ps(a4, sum4);
  }

  // Horizontal addition
  sum4 = _mm_hadd_ps(sum4);
  sum4 = _mm_hadd_ps(sum4);

  result = _mm_extract_ps(sum4, 0);

  return (result/size)
}
