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
line_count=$(wc $FileName| awk '{print $1}')
echo


for name in `seq $line_count` ; do
    read name
    echo $name
    if [ "$name" = Smith ] ; then
	break
    fi
done <"$FileName"

exit 0
