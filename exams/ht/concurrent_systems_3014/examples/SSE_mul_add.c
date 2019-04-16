#include<xmmintrin.h>

#define SIZE 4096

float vals[SIZE];
float a, b;

int main(){
  load_vals();

  __m128 va = _mm_set1_ps(a); /* va contains 4 copies of a */
  __m128 vb = _mm_set1_ps(b); /* vb contains 4 copies of b */

  for (int i=0; i<SIZE; i+=4) { /* careful! SIZE must be multiple of 4! */

    // V = load_vector()
    __m128 v = _mm_load_ps(&vals[i]);

    // v = v * a
    v = _mm_mul_ps(v, va);
    // v = v+b
    v = _mm_add_ps(v, vb);

    // vals[i] = vals[i]*a+b;
    _mm_store_ps(&vals[i], v);
  }
}
