__m128 a = _mm_set1_ps(0.0f);
__m128 b = _mm_set1_ps(1.0f);
__m128 r = _mm_cmpgt_ps(a, b);

// Convert mask into 4-bit integer
if( _mm_movemask_ps(r) == 0xF){
  printf("a is greater than b\n");

} else if (_mm_movemask_ps(r) == 0){
  printf("a is NOT greater than b");

} else {
  printf("mixed result");

}
