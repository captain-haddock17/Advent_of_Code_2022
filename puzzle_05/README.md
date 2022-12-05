## Note

### Design

`puzzle_05` (415 SLoC) :: Ada centric solution

* Plain Ada, using traditional `push`, `pop`, `insert` of elements in a stack (*pile*) with access type.

Note:

* NOT using any of the `Ada.Containers` i.e *moves* of crates are processed while reading the data file -- no recording.
* Could have best used `Ada.Text_IO.Text_Streams` and `Ada.Streams` to read *move* records of second part of data file. (see `package Cranes_IO`)

### Build

```shell
cd puzzle_05
alr build
```

### Run

```shell
bin/puzzle_05 data/test.dat
bin/puzzle_05 data/input.dat
```

Run with some traces

```shell
bin/puzzle_05 -t data/test.dat
```

Run with help

```shell
bin/puzzle_05 -h
```
