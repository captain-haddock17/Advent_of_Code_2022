## Note

### Design

`puzzle_04` (254 SLoC) :: Ada centric solution

* Using `Ada.Text_IO.Text_Streams` and `Ada.Streams` to read each record (line) of data, implementing `Data_Record'Read (Data_Stream, Data);`.

```ada
   type Data_Record is record
      Elf_1_assignement : Section_Range;
      Separator : Character := ',';
      Elf_2_assignement : Section_Range;
   end record;

   procedure Read_Record (...);
   for Data_Record'Read use Read_Record;
(...)
   type Section_Range is record
      First : First_Section_ID;
      Last  : Last_Section_ID;
   end record;

   procedure Read_Section ( ...);
   for Section_Range'Read use Read_Section;
```

### Build

```shell
cd puzzle_04
alr build
```

### Run

```shell
bin/puzzle_04 data/test.dat
bin/puzzle_04 data/input.dat
```

Run with some traces

```shell
bin/puzzle_04 -t data/test.dat
```

Run with help

```shell
bin/puzzle_04 -h
```
