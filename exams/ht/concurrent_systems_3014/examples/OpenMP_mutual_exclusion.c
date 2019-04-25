/* Compute sum of array of ints  BAD!! */
int sum = 0;
#pragma omp parallel for
{
	for ( i = 0; i < n; i++ ) {
		#pragma omp critical
		sum += a[i];
	}
}

/* Compute sum of array of ints  FAST !! */
int sum = 0;
#pragma omp parallel
{
	int local_sum = 0;
	#pragma omp for
	for ( i = 0; i < n; i++ ) {
		local_sum += a[i];
	}
	#pragma omp critical
	sum += local_sum;
}

/* compute sum of array of ints */
int sum = 0;
int local_sum = 0;
#pragma omp parallel firstprivate(local_sum)
	{
	/* local_sum in here is initialised with local sum value from outside */
	#pragma omp for
	for ( i = 0; i < n; i++ ) {
		local_sum += a[i];
	}
	#pragma omp critical
	sum += local_sum;
}

/* example of requiring all variables be declared shared or non-shared */
#pragma omp parallel default(none) shared(n,x,y) private(i)
{
	#pragma omp for
	for (i=0; i<n; i++)
		x[i] += y[i];
}
