/* OpenMP automatically combines the local copies together to create a final value at the end of the parallel section */
int sum = 0;
#pragma omp parallel for reduction(+:sum)
{
	for ( i = 0; i < n; i++ ){
		sum += a[i];
	}
}
