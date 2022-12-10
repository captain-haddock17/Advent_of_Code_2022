## Note

### Design

`puzzle_09` (376 SLoC) :: Ada *geek* solution

* Using *In Strong Typing We Trust*
   *  `X` and `Y` coordinates are different *types* so you can NOT confuse/invert them!
* Using `Ada.Containers.Hashed_Sets` to record displacements of the *Tail's rope*
* Using `Ada.Streams` and `Ada.Text_IO.Text_Streams` to get the data from the file -- I *definitively* love `Streams` ;-)
* Tracing is implemented as a kind of [Aspect programming](https://en.wikipedia.org/wiki/Aspect-oriented_programming) design

Limitations:
* In trace mode, `Grid_range` is limited to -12 .. 15


### Build

```shell
cd puzzle_09
alr build
```

### Run

```shell
bin/puzzle_09 data/test.dat
bin/puzzle_09 data/input.dat
```

Run with some traces

```shell
bin/puzzle_09 -t data/test.dat
```

Run with help

```shell
bin/puzzle_09 -h
```
