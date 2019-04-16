/* Iterations of the loops are divided amongst threads */
#pragma omp parallel for
for (i = 0; i < n; i++ ) {
  a[i] = b[i] * c[i];
}

/* Parallel sections allow different things to be done by different threads */
#pragma omp parallel sections
{
	#pragma omp section
	{
		min = find_min(a);
	}
	#pragma omp section
	{
		max = find_max(a);
	}
}

/* Parallel tasks are parallel jobs that can be done in any order */
#pragma omp parallel
{
	#pragma omp single  // just one thread does this bit
	{
		#pragma omp task
		{
			printf(“Hello “);
		}
		#pragma omp task
		{
			printf(“world ”);
		}
	}
}

/* There is no dependency between loops here, so fire ahead when threads free */
#pragma omp parallel
{
	#pragma omp for nowait
	for ( i = 0; i < n; i++ )
		a[i] = b[i] + c[i];
	#pragma omp for
	for ( i = 0; i < m; i++ )
		x[j] = b[j] * c[j];
}
