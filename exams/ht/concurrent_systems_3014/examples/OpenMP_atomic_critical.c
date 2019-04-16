/* example of requiring all variables be declared shared or non-shared */
#pragma omp parallel default(none) shared(n,x,y) private(i)
{
	#pragma omp for
	for (i=0; i<n; i++)
		x[i] += y[i];
}
