# Advent of Code 2022

Some Ada source-code proposals for the puzzles of the © [Advent of Code, year 2022](https://adventofcode.com/2022) contest prepared by [Eric Wastl](http://was.tl) 😎

## Follow links in this calendar

|MON|TUE|WED|THU|FRI|SAT|SUN|
|--|--|--|--|--|--|--|
|-|-|-|[01](./puzzle_01)|[02](./puzzle_02)|[03](./puzzle_03)|04|
|05|06|07|08|09|10|11|
|12|13|14|15|16|17|18|
|19|20|21|22|23|24|25|

Note: There are still other GitHub repositories (20+) with Ada code proposals.

---

## Goals

Aiming as a show-case of some best(?) Ada 2012/2022 coding practices.

1. [Readability](https://www.adaic.org/resources/add_content/docs/95style/html/sec_3/toc.html)
1. [Modular](https://www.adaic.org/resources/add_content/docs/95style/html/sec_4/toc.html) & [Object Oriented](https://www.adaic.org/resources/add_content/docs/95style/html/sec_9/9-1.html) software design
1. Only using the libraries defined by the language, and shipped with any Ada compiler
1. Use [multi-tasking design](https://www.adaic.org/resources/add_content/docs/95style/html/sec_6/) when appropriate
1. Execution time (performance) is not a *first class* goal (back to 1. & 2.)

## Comments are welcome 😃

Other seasoned or just plain beginner developer have published their Ada code on github (or elsewhere...)

---

## Ada 2022

I used the forthcoming [Ada 2022 syntax and language-libraries](http://www.ada-auth.org/standards/ada22.html), essentially:

* `@` as a shorthand syntax, as in `Sum := @ + 1;`

---

## Tools used

* Pretty Printer: [GNAT pretty-printer](https://docs.adahttps://docs.adacore.com/gnat_ugn-docs/html/gnat_ugn/gnat_ugn/gnat_utility_programs.html#the-gnat-pretty-printer-gnatpp)
* Compiler: GNAT from [GCC 12.2.0](https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gnat_ugn/)
* Build: [GNAT gprbuild](https://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html)
* Package-Library manager: [Alire](https://alire.ada.dev)

These Ada source code have been written and built on [macOS](https://www.apple.com/macos/ventura/), and also rebuilt and deployed on [FreeBSD](https://www.freebsd.org/about/) (as in CI/CD).

---

## How to Build & Run

Alire (`alr`) needs to be initialized through a first `alr build` command. This completes `~/.config/alire/config.toml` file.

To select the working Ada 2022 (WIP) compiler:

* `alr toolchain --select`

One may use plain `gprbuild` instead of `alr build`.

Typically:

```shell
git clone https://github.com/AdaForge/Advent_of_Code_2022.git
cd Advent_of_Code_2022/puzzle_08
alr build
bin/puzzle_08 data/input.txt
```

---
## Some excellent Ada web info & Ada programming resources

Take a look at [AdaForge.org](https://www.adaforge.org)


---

## License & Disclaimers

Just plain open-source: [CC0 Universal Public Domain dedication](https://creativecommons.org/publicdomain/zero/1.0/deed.fr)'s
_Free Cultural Work_
