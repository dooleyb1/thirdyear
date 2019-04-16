#pragma omp parallel {
	/* all threads do the same thing here */
	#pragma omp for
	for ( i = 0; i < n; i++ ) {
		/*loop iterations divided between threads*/
	}
	/* there is an implicit barrier here that makes all threads wait until all are finished */
	#pragma omp sections
	{
		#pragma omp section
		{
			/* executes in parallel with code from other section */
		}
		#pragma omp section
		{
			/* executes in parallel with code from other section */
		}
	}
	/* there is an implicit barrier here that makes all threads wait until all are finished */
	/* all threads do the same thing again */

  /* EACH THREAD WILL EXECUTE THIS ONCE */
  #pragma omp parallel
  {
  	#pragma omp atomic
  	x++;
  }

  /* ONLY ONE THREAD CAN BE IN HERE AT A TIME */
  #pragma omp parallel
  {
  	#pragma omp atomic
  	x++;
  }

}
