#!/bin/bash -
#===============================================================================
#
#          FILE: function_array.sh
#
#         USAGE: ./function_array.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: du fei (), fei.du@nxp.com
#  ORGANIZATION: PETE
#       CREATED: 2018年01月14日 12时07分40秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

function testit {
    local newarray
    local sum=0
    newarray=($(echo "$@"))
    # echo "the new array value is: ${newarray[*]}"

    for value in ${newarray[*]} ; do
	sum=$[ $sum + $value ]
    done
    echo $sum
}

myarray=(1 2 3 4 5)
echo "The original array is ${myarray[*]}"
result=$( testit ${myarray[*]} )
echo
echo "the result is $result"

function arraydblr {
    local origarray
    local newarray
    local elements
    local i

    origarray=($(echo "$@"))
    newarray=($(echo "$@"))
    elements=$[ $# - 1 ]


    for (( CNTR=0; CNTR<$elements; CNTR+=1 )); do
	newarray[$CNTR]=$[ ${origarray[$CNTR]} * 2 ]
    done
    echo ${newarray[*]}
}

arg1=$(echo ${myarray[*]})
result=($(arraydblr $arg1))
echo "the new array is: ${result[*]}"
