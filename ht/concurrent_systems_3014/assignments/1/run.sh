#!/usr/bin/env bash

# Compile program
/usr/local/bin/gcc-8 -O3 -fopenmp -msse4 -o conv-harness conv-harness.c
echo "GCC Finished..."

# Run performance tests
echo "Running tests..."

# Usage: conv-harness <image_width> <image_height> <kernel_order> <number of channels> <number of kernels>
./conv-harness 128 128 5 32 100
./conv-harness 32 32 3 64 1024
./conv-harness 255 255 1 63 127
./conv-harness 192 192 7 1 512
./conv-harness 256 256 5 64 64
