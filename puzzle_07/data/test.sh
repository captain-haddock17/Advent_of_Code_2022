#!/bin/sh
mkdir test; cd test
echo ls
mkdir a
dd if=/dev/urandom bs=14848514 count=1 of=b.txt
dd if=/dev/urandom bs=8504156 count=1 of=c.dat
mkdir d
cd a
echo ls
mkdir e
dd if=/dev/urandom bs=29116 count=1 of=f
dd if=/dev/urandom bs=2557 count=1 of=g
dd if=/dev/urandom bs=62596 count=1 of=h.lst
cd e
echo ls
dd if=/dev/urandom bs=584 count=1 of=i
cd ..
cd ..
cd d
echo ls
dd if=/dev/urandom bs=4060174 count=1 of=j
dd if=/dev/urandom bs=8033020 count=1 of=d.log
dd if=/dev/urandom bs=5626152 count=1 of=d.ext
dd if=/dev/urandom bs=7214296 count=1 of=k