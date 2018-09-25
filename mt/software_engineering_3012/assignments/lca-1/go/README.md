# Lowest Common Ancestors - Go (Golang)

This repository contains a solution to the lowest common ancestors problem in relation to graph theory written in Go.

## Testing

To run the tests (verbosely) do:

```shell
go test -v
```

To run the tests with code coverage do:

```shell
go test -cover

```

To generate HTML code coverage report do:

```shell
go test -cover -coverprofile=c.out
go tool cover -html=c.out -o coverage.html
```
