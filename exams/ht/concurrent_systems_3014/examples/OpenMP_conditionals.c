#define DEBUGGING 1

/* This will only be parallelised if DEBUGGING defined */
#pragma omp parallel for if (!DEBUGGING)
for ( i = 0; i < n; i++ )
	a[i] = b[i] * c[i];

/* This will only be parallelised if loop condition > 128 */
#pragma omp parallel for if ( n > 128 )
for ( i = 0; i < n; i++ )
	a[i] = b[i] + c[i];
