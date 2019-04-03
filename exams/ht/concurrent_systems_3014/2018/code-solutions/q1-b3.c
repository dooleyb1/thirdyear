// http://shybovycha.tumblr.com/post/122400740651/speeding-up-algorithms-with-sse

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
#include <xmmintrin.h>

int compute(int* array, int SIZE){
  // Array is 16-byte aligned address
  int max;

  // Set max to [0, 0, 0, 0]
  __m128i maxval = _mm_setzero_si128();
  __m128i elements

  // Reduce four loop by 8 (4 * 32-bit integers)
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
