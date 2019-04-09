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
#include <xmmintrin.h>

bool strcmp(char* string1, char* string2, int strlength){

  // Using SSE we can load 16 * 8-bit char's at a time
  for(int i=0; i<strlength; i+=16){

    // Load 16 chars from string1 and string2 into vectors
    __m128i string1Vector = _mm_load_si128((__m128i *) string1[i]);
    __m128i string2Vector = _mm_load_si128((__m128i *) string2[i]);

    // Compare vecotrs
    __m128i vcmp = _mm_cmpeq_epi8(string1Vector, string2Vector);

    // Extract result
    int result;
    _mm_store_si128((__m128i *)result, vcmp);

    // If strings are not equal, return false
    if(!result) return false
  }
}
