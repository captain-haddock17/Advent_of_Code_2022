### Note

1. Design

`puzzle_03` (181 SLoC) :: Ada centric solution

* Using a bloc `declare` in the loop reading each line of file, as to cope with different data (string) lengths.
* Using `Ada.Containers.Hashed_Sets` to find out the common item in *compartments in rucksack* (Part 1), or in a *group of rucksacks* (Part 2).
* Note the usage of `exception` to handle edge cases witch should not happen with correct data file (... but who knows?!?!):
  * `Item_Out_of_Bounds`
  * `Empty_Rucksack_Compartment`
  * `No_Common_Badge`

`puzzle_03_light` (100 SLoC) :: Light and compact version, using `Character` and using less custom types

* Using `Ada.Strings.Fixed`
* Using a `Priority_List` defined as `String` to compute the *Priority*
* Using standard Unix input `Standard_Input`

2. Build

```shell
cd puzzle_03
alr build
```

3. Run

```shell
bin/puzzle_03 data/test.dat
bin/puzzle_03 data/input.dat
bin/puzzle_03_light < data/input.dat

```

Run with some traces

```shell
bin/puzzle_03 -t data/test.dat
```

Run with help

```shell
bin/puzzle_03 -h
```
