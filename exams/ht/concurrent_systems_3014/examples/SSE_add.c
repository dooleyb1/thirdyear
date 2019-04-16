#include <xmmintrin.h>

/*
 *  Function to add a single lane vector to a multi lane vector
 *
 *  VectorA = [ 1 | 2 | 3 | 4 ]
 *  VectorB = [ 5 ]
 *
 *
 *
 *  VectorC = [ 6 | 7 | 8 | 9 ]
 *
*/
__m128 a = _mm_setr_ps(1.0f, 2.0f, 3.0f, 4.0f);
__m128 b = _mm_set1_ps(5.0f);
__m128 c = _mm_add_ps(a, b);
