#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

testfile=$(ls *.sh)
echo "$testfile"

z=3
z=$((z+3))
echo $z
z=$(($z+4))
echo $z
fun() { echo "this is a function"; }
fun
