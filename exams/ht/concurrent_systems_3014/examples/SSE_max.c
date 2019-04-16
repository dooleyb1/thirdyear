#include <xmmintrin.h>

/*
 *  Function to calculate maximum values between two vector lanes
 *
 *  VectorA = [ 2 | 3 | 1 | 9 ]
 *  VectorB = [ 4 | 1 | 8 | 2 ]
 *
 *  Mask = [ 0 | -1 | 0 | -1 ]          Since 2 !> 4, 3 > 1 etc..
 *
 *  Tmp1 = [ 0 | 3 | 0 | 9 ]
 *  Tmp2 = [ 4 | 0 | 8 | 0 ]
 *
 *  Result = [ 4 | 3 | 8 | 9 ]
*/
__m128 our_max(__m128 a, __m128 b){

  // Declare variables
  __m128 result, tmp1, tmp2;

  // Mask = a > b
  __m128 mask = _mm_gt_ps(a, b);

  tmp1 = _mm_and_ps(a, mask);
  tmp2 = _mm_and_ps(b, mask);

  result = _mm_xor_ps(tmp1, tmp2);

  return result
}
