#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error
fileName=$(basename $0)
echo Usage: $fileName
echo {A..Z}
{
    echo
    echo "second line"
    whoami
    echo "finished"
} > file.txt
echo "$(echo 'hle')"
echo "$(whoami)"

echo "\v\v\v\v"      # Prints \v\v\v\v literally.
# Use the -e option with 'echo' to print escaped characters.
echo "============="
echo "VERTICAL TABS"
echo -e "\v\v\v\v"   # Prints 4 vertical tabs.

echo -e "hello\nworld"
echo  "hello\nworld"
# The $'\X' construct makes the -e option unnecessary.
echo hello $'\n' world
# assigning ASCII characters to a variable
quote=$'\042'
echo "$quote quoted string $quote and this lies outside the quotes"

# concatenating ASCII chars in a variable
triple_underline=$'\137\137\137'
echo "$triple_underline UnderLINE $triple_underline"
