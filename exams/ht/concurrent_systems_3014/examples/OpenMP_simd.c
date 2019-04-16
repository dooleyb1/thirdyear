/* This instructs the compiler to vectorise the loop - MAY BE WRONG VECTORISATION */
#pragma omp simd
for (i = 0; i < N; i++ ) {
	a[i] = a[i] + s * b[i];
}

/* This loop CAN NOT be vectorised because of the data dependency */
for ( i = 1; i < n; i++ ) {
	a[i] = sqrt(a[i-1]) + b[i];
	}

/* This loop CAN be vectorised because of the safe length of 10 */
#pragma omp simd safelen(10)
for ( i = 10; i < n; i++ ) {
  a[i] = sqrt(a[i-10]) + b[i];
}
