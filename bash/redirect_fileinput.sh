#!/bin/bash -
#===============================================================================
#
#          FILE: redirect_fileinput.sh
#
#         USAGE: ./redirect_fileinput.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月14日 09时04分54秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

exec 6<&0

exec 0< text.txt

count=1

while read line ; do
    echo "line $count: $line"
    count=$[ $count + 1 ]
done

exec 0<&6
read -p 'are you done now?' answer

case $answer in
    Y|y)
	echo goodbye ;;

    N|n)
	echo sorry, ending ;;

esac    # --- end of case ---
