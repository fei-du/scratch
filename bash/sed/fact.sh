#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

factorial=1
counter=1
number=$1


while [ $counter -le $number ] ; do
    factorial=$[ $factorial * $counter ]
    counter=$[ $counter + 1 ]
done

result=$( echo $factorial | sed '{
:start
s/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/
t start
}')
echo "the result is $result"
