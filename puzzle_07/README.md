## Note

### Design

`puzzle_07` (299 SLoC) :: Ada centric solution

* Implementing a generic *Round Robin* buffer with a `Protected type`
* Implementing generic of generic
* Using `Ada.Strings.Maps` for the fun (beauty) of it
```ada
function Is_In (Element : in Character;
                Set     : in Character_Set)
```
* Using `Ada.Text_IO.Text_Streams` to handle the input (data stream as in *real* life)
* TODO: factoring out some code into a unique procedure call `Analyse_Buffer`

### Build

```shell
cd puzzle_07
alr build
```

### Run

```shell
bin/puzzle_07 data/test.dat
bin/puzzle_07 data/input.dat
```

Run with some traces

```shell
bin/puzzle_07 -t data/test.dat
```

Run with help

```shell
bin/puzzle_07 -h
```
