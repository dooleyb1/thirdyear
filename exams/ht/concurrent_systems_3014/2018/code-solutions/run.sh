#!/usr/bin/env bash

# Compile program
/usr/local/bin/gcc-8 -O3 -fopenmp -msse4 -o matrix_max q2.c
echo "GCC Finished..."

# Run performance tests
echo "Running ..."
./matrix_max
