# CS3016 Exercises

This repo contains the Haskell Labs/Exercises for CS3016 in academic year 2018-19.

## Installing Stack

`stack` is installed on ICTLAB machines,
and the Schools Unix machines for students.

To install on your own machine go to
[https://docs.haskellstack.org/en/stable/README/](https://docs.haskellstack.org/en/stable/README/)
and follow instructions carefully.


## Accessing Exercises

If `git` is not installed on your machine, please make it so (via [https://git-scm.com](https://git-scm.com) or elsewhere).

The first time, use a command-line tool to navigate to where you want to keep your CS3016 coursework and enter:

```
git clone http://gitlab.scss.tcd.ie/butrfeld/CS3016-1819.git
```

You may need to authenticate using your SCSS username and SCSS password. This should create a folder called `CS3016-1819`. 

To get future coursework updates, enter folder `CS3016-1819`
and issue the command

```
git pull
```


## Generic Lab Instructions

We assume you start in the directory called CS3016-1819

### Command-Line setup

Start up a command-line application

e.g. `Terminal` on OS X, or `cmd` on Windows.

### Important: for School-supplied Windows machines in ICTLAB I or II

Run the batchfile `ICTLAB-SETUP.bat` here first.

Do **not** do this on your own personal Windows machine!

### Access relevant sub-directory

For Exercise NN go into the sub-folder called `ExerciseNN` and read the `ExerciseNN.md` file
for further instructions.

So, for Exercise 00, goto sub-folder `Exercise00`, and follow the instructions in `Exercise00.md`.

### Testing your code

From the command line, issue the following command

```
> stack test
```

You might have to wait a while, 
particularly if this is the first time you do this.

Your task is to get all the tests to succeed.

### Submitting your work

Each exercise will have specific
instructions as to what should be uploaded. This may just be one or two Haskell sourcefiles that you were asked to create and/or modify, or it could involve compressing and uploading the entire `ExerciseNN` folder.

Upload the corresponding material to Blackboard.

