#!/bin/bash -
#===============================================================================
#
#          FILE: recursion.sh
#
#         USAGE: ./recursion.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: du fei (), fei.du@nxp.com
#  ORGANIZATION: PETE
#       CREATED: 2018年01月14日 14时47分46秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
function factorial {

if [ $1 -eq 1 ] ; then
    echo 1
else
    local temp=$[ $1 -1 ]
    local result=$(factorial $temp)
    echo $[ $result * $1 ]
fi
}

read -p "Enter value: " value
result=$(factorial $value)
echo the factorial of $value is: $result
