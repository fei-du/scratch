#!/bin/bash -
# set -o nounset                                  # Treat unset variables as an error

if [ -z "$1" ] ; then
    FileName=names.data
else
    FileName=$1
fi

# FileName=${1:-names.data}
# can replace the above test

Savefile=$FileName.new
FinalName=Jonah

line_count=$(wc $FileName| awk '{print $1}')
echo


for name in $( seq $line_count ) ; do
# for name in `seq $line_count` ; do #either is working
    read name
    echo $name
    if [ "$name" = "$FinalName" ] ; then
	break
    fi
done <"$FileName" > "$Savefile"

exit 0
