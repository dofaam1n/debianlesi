#!/bin/bash

echo "a directory is created in the format YYYY-MM-DD"
D=`date +%F`
mkdir $D
cd $D

echo "in which 100 files are created. each file is filled with one line with a random number"
for i in {1..100}
do
R=$(head -1 /dev/urandom | od -N 1 | awk '{ print $2 }')
let "rnum = $RANDOM % 9000 + 1000"
echo $rnum > File$i
done

