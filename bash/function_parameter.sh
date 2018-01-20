#!/bin/bash -
#===============================================================================
#
#          FILE: function_parameter.sh
#
#         USAGE: ./function_parameter.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: du fei (), fei.du@nxp.com
#  ORGANIZATION: PETE
#       CREATED: 2018年01月14日 11时51分46秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

function addem {
if [ $# -eq 0 ] || [ $# -gt 2 ] ; then
    echo -1
elif [ $# -eq 1 ]; then
    echo $[ $1 + $1 ]
else
    echo $[ $1 + $2 ]
fi
}

echo -n 'Adding 10 and 15: '
value=$(addem 10 15)
echo $value

echo -n "let's try adding just one number: "
value=$(addem 10)
echo $value

echo -n "adding no number: "
value=$(addem)
echo $value


function func1 {
    local temp=$[ $value + 5 ]
    result=$[ $temp * 2 ]
}

temp=4
value=6

func1
echo "the results is $result"

if [ $temp -gt $value ] ; then
    echo "temp is larger"
else
    echo "temp is smaller"
fi
