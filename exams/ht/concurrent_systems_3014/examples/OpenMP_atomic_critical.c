/*
 * An atomic update can update a variable in a single unbreakable step
 *
 * This code guarantees x will incremement by the number of threads
*/
#pragma omp parallel
{
	#pragma omp atomic
	x++;
}


/* Only ONE THREAD can be inside a critical section at any one time */
#pragma omp parallel
{
	#pragma omp critical
	{
		x++;
	}
}

/* All critical sections clash with each other, so naming them is a good idea */
#pragma omp parallel
{
	#pragma omp critical  (update_x)
	{
		x++;
	}
}
