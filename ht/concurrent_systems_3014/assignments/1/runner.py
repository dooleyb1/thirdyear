from subprocess import call

# call(["/usr/local/bin/gcc-8", "-O3", "-fopenmp",  "-msse4", "pob.c"])
# call(["echo", "GCC finished"])

call(["/usr/local/bin/gcc-8", "-O3", "-fopenmp",  "-msse4", "conv-harness.c"])
call(["echo", "GCC finished"])

call(["echo", "Running tests..."])
call(["./a.out", "128", "128", "5", "32", "100"])
call(["./a.out", "32", "32", "3", "64", "1024"])
call(["./a.out", "255", "255", "1", "63", "127"])
call(["./a.out", "192", "912", "7", "1", "512"])
call(["./a.out", "256", "256", "5", "64", "64"])
