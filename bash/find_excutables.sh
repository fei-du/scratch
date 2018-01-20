#!/bin/bash -
#===============================================================================
#
#          FILE: find_excutables.sh
#
#         USAGE: ./find_excutables.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME dufei
#  ORGANIZATION: 
#       CREATED: 2018年01月13日 17时25分12秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

IFS=:


for folder in $PATH ; do
    echo "$folder:"
    for file in $folder/* ; do
	
	if [ -x $file ] ; then
	    echo "   $file"
	fi
    done
done
