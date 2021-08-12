#!/bin/bash -
# set -o nounset                                  # Treat unset variables as an error

if [ -z "$1" ] ; then
    FileName=names.data
else
    FileName=$1
fi

# FileName=${1:-names.data}
# can replace the above test

count=0

echo

while [ "$name" != Smith ] ; do
    read name
    echo $name
    let "count += 1"
done < "$FileName"

echo; echo "$count names read"; echo
exit 0
