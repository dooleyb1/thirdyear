
__m128 a = _mm_setr_ps(1.0f, 2.0f, 3.0f, 4.0f);     /* load floats into vector */
__m128 b = _mm_set1_ps(5.0f);                       /* load 4 copies of a float into vector */

__m128 c = _mm_add_ps(a, b);                        /* add individual elements of vectors a and b */
__m128 c = _mm_sub_ps(a, b);                        /* add individual elements of vectors a and b */
__m128 d = _mm_mul_ps(a, b);                        /* multiply individual elements of vectors a and b */

__m128 e = _mm_min_ps(a, b);                        /* minimum between each element in both vectors */
__m128 f = _mm_max_ps(a, b);                        /* maximum between each element in both vectors */

__m128 g = _mm_sqrt_ps(a);                          /* square root of 4 floats **SLOW** */
__m128 h = _mm_rcp_ps(a);                           /* reciprocal of 4 floats **FAST** */

__m128 i = _mm_hadd_ps(a, b);                       /* horizontally add a and b */
__m128 j = _mm_hsub_ps(a, b);                       /* horizontally sub a and b */

__m128 v = _mm_load_ps(&vals[i]);                   /* load 4 floats from aligned address &vals[i] */
__m128 v = _mm_loadu_ps(&vals[i]);                  /* load 4 floats from unaligned address &vals[i] */
__m128 v = _mm_load1_ps(&vals[i]);                  /* load 1 float into all 4 slots of vector from address &vals[i] */

_mm_store_ps(float *dest, __m128 src);              /* store 4 floats to aligned address */
_mm_storeu_ps(float *dest, __m128 src);             /* store 4 floats to unaligned address */
