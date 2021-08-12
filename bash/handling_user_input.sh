#!/bin/bash -
#===============================================================================
#
#          FILE: handling_user_input.sh
#
#         USAGE: ./handling_user_input.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月13日 21时50分10秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

if [ -n "$1" ] ; then
    echo Hello $1, glad to meet you
else
    echo "sorry, you didn't identify yourself."
fi


if [ $# -ne 2 ] ; then
    echo
    echo Usage: test9.sh a b
    echo
else
    total=$[ $1 + $2 ]
    echo
    echo the total is $total
    echo
fi
