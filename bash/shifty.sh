#!/bin/bash -
#===============================================================================
#
#          FILE: shifty.sh
#
#         USAGE: ./shifty.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月13日 22时05分53秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

echo
count=1

while [ -n "$1" ] ; do
    echo "parameter $count = $1"
    count=$[ $count + 1 ]
    shift
done
