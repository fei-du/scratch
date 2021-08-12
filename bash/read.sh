#!/bin/bash -
#===============================================================================
#
#          FILE: read.sh
#
#         USAGE: ./read.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月14日 08时47分28秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
count=1
cat text.txt | while read line ; do
    echo "line $count: $line"
    count=$[ $count + 1 ]
done
echo finished processing the file
