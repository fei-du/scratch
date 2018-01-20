#!/bin/bash -
#===============================================================================
#
#          FILE: function.sh
#
#         USAGE: ./function.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: du fei (), fei.du@nxp.com
#  ORGANIZATION: PETE
#       CREATED: 2018年01月14日 11时39分46秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
function func1 {
    echo 'this is an example of a function'
}

count=1

while [ $count -le 5 ] ; do
    func1
    count=$[ $count + 1 ]
done
echo 'done'
func1
echo 'finally done'


function dbl {
    read -p "enter a value: " value
    echo $[ $value * 2 ]
}

result=$(dbl)
echo the new value is $result
