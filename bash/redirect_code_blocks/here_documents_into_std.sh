#!/bin/bash -
# set -o nounset                                  # Treat unset variables as an error

function doesOutput()
# could be an external command too.
# here we show you can use a function as well
{
    ls -al *.sh | awk '{print $5,$9}'
}


nr=0
totalSize=0o

while read fileSize fileName ; do
    echo "$fileName is $fileSize bytes"
    let "nr++"
    # totalSize=$(( totalSize+fileSize))
done<<EOF
$(doesOutput)
EOF


echo "$nr files totaling $totaling bytes"
