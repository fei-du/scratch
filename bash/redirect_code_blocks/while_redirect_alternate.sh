#!/bin/bash -
# set -o nounset                                  # Treat unset variables as an error

if [ -z "$1" ] ; then
    FileName=names.data
else
    FileName=$1
fi

# FileName=${1:-names.data}
# can replace the above test
exec 3<&0
exec 0<"$FileName"

count=0
echo

while [ "$name" != Smith ] ; do
    read name
    echo $name
    let "count += 1"
done

exec 0<&3
exec 3<&-

echo; echo "$count names read"; echo
exit 0
